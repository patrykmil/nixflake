#!/usr/bin/env python3
import argparse
import json
import re
import socket
import subprocess
import sys
from pathlib import Path

CHANNEL_OF_SET = {
    "pkgs": "26.05",
    "pkgs-unstable": "unstable",
    "pkgs-master": "master",
}
CHANNEL_ORDER = ["26.05", "unstable", "master"]
CHANNEL_COLORS = {
    "26.05": "\033[1;32m",
    "unstable": "\033[1;33m",
    "master": "\033[1;35m",
}
RESET = "\033[0m"
DIM = "\033[2m"
STOP_WORDS = {
    "true",
    "false",
    "null",
    "inherit",
    "with",
    "let",
    "in",
    "rec",
    "default",
    "packages",
    "override",
    "overrideAttrs",
    "outPath",
    "outputName",
    "type",
}


def find_flake_root():
    here = Path(__file__).resolve().parent
    for parent in [here] + list(here.parents):
        if (parent / "flake.nix").exists():
            return parent
    return Path.cwd()


def strip_noise(text):
    text = re.sub(r"''(?:[^']|'(?!'))*''", " ", text, flags=re.S)
    text = re.sub(r'"(?:\\.|[^"\\\n])*"', " ", text)
    text = re.sub(r"#[^\n]*", "", text)
    text = re.sub(r"\$\{[^{}]*\}", " ", text)
    return text


def capture_block(text, open_idx):
    depth = 0
    for i in range(open_idx, len(text)):
        if text[i] == "[":
            depth += 1
        elif text[i] == "]":
            depth -= 1
            if depth == 0:
                return text[open_idx + 1 : i], i + 1
    return text[open_idx + 1 :], len(text)


def binding_name(text, pos):
    m = re.search(r"([A-Za-z_][\w'-]*)\s*=$", text[:pos])
    return m.group(1) if m else ""


def collect_packages(root, host):
    found = {}
    for path in sorted(root.rglob("*.nix")):
        if ".git" in path.parts or path.name == "hardware-configuration.nix":
            continue
        text = strip_noise(path.read_text())
        excludes = set(
            re.findall(r"([A-Za-z_][\w'-]*)\s*=\s*[(\s]*(?:inputs|pkgs(?:-unstable|-master)?)\s*\.", text)
        )
        for m in re.finditer(r"=\s*with\s+(pkgs(?:-unstable|-master)?)\s*;\s*\[", text):
            channel = CHANNEL_OF_SET[m.group(1)]
            binder = binding_name(text, m.start())
            if binder in ("desktop", "laptop") and binder != host:
                continue
            bodies = []
            idx = m.end() - 1
            while True:
                body, idx = capture_block(text, idx)
                bodies.append(body)
                cont = re.match(r"\s*\+\+\s*\[", text[idx:])
                if not cont:
                    break
                idx += cont.end() - 1
            for body in bodies:
                for tok in re.findall(r"[A-Za-z_][\w'-]*(?:\.[A-Za-z_][\w'-]*)*", body):
                    head = tok.split(".")[0]
                    if tok in STOP_WORDS or head in STOP_WORDS or tok.startswith("inputs.") or head == "pkgs":
                        continue
                    if tok in excludes or head in excludes:
                        continue
                    found.setdefault((channel, tok), path.name)
    return found


def lock_refs(root):
    lock = json.loads((root / "flake.lock").read_text())
    refs = {}
    for inp, channel in [
        ("nixpkgs", "26.05"),
        ("nixpkgs-unstable", "unstable"),
        ("nixpkgs-master", "master"),
    ]:
        node = lock["nodes"][lock["nodes"][lock["root"]]["inputs"][inp]]
        orig, locked = node["original"], node.get("locked", {})
        base = f"github:{orig['owner']}/{orig['repo']}"
        cur = f"{base}/{locked['rev']}" if locked.get("rev") else f"{base}/{orig.get('ref', 'HEAD')}"
        refs[channel] = (cur, f"{base}/{orig.get('ref', locked.get('ref', 'HEAD'))}")
    return refs


def build_expr(refs, grouped):
    parts = []
    for channel in CHANNEL_ORDER:
        names = sorted(set(grouped.get(channel, [])))
        if not names:
            continue
        cur, new = refs[channel]
        quoted = " ".join(json.dumps(n) for n in names)
        parts.append(
            f'{json.dumps(channel)} = {{ cur = mk "{cur}"; new = mk "{new}"; names = [ {quoted} ]; }};'
        )
    if not parts:
        sys.exit("No packaged declarations found")
    body = "\n  ".join(parts)
    return (
        "let\n"
        "  mk = url: (builtins.getFlake url).legacyPackages.${builtins.currentSystem};\n"
        "  ver = s: n:\n"
        "    if ! s ? ${n} then null\n"
        "    else (builtins.tryEval (if s.${n} ? version then s.${n}.version else null)).value;\n"
        "  probe = c: builtins.listToAttrs (map (n: {\n"
        "    name = n;\n"
        "    value = { old = ver c.cur n; new = ver c.new n; };\n"
        "  }) c.names);\n"
        "in builtins.mapAttrs (_: probe) {\n  " + body + "\n}\n"
    )


def evaluate(refs, grouped, refresh):
    cmd = ["nix", "eval", "--impure", "--json", "--expr", build_expr(refs, grouped)]
    if refresh:
        cmd.insert(2, "--refresh")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        sys.exit(f"nix eval failed:\n{result.stderr.strip()}")
    raw = json.loads(result.stdout)
    return {
        c: {name: (data.get("old"), data.get("new")) for name, data in raw.get(c, {}).items()}
        for c in CHANNEL_ORDER
    }


def render(channel, entries, use_color, show_all):
    color = CHANNEL_COLORS[channel] if use_color else ""
    suffix_reset = RESET if color else ""
    lines = [f"{color}{channel}{suffix_reset}"]
    shown = 0
    for name in sorted(entries):
        old, new = entries[name]
        if old is None and new is None:
            continue
        changed = old != new
        if not changed and not show_all:
            continue
        shown += 1
        old_s = old if old is not None else "?"
        new_s = new if new is not None else "gone"
        suffix = "" if changed else (f" {DIM}(up to date){RESET}" if use_color else " (up to date)")
        lines.append(f"  {name} {old_s} --> {new_s}{suffix}")
    if shown == 0:
        lines.append(f"  {DIM}up to date{RESET}" if use_color else "  up to date")
    return lines


def main():
    parser = argparse.ArgumentParser(
        description="Compare installed packages against the newest versions on their nixpkgs channel"
    )
    parser.add_argument("--all", action="store_true", help="also show up-to-date packages")
    parser.add_argument("--refresh", action="store_true", help="force re-fetch of channel heads")
    parser.add_argument("--no-color", action="store_true", help="disable colored output")
    args = parser.parse_args()

    root = find_flake_root()
    host = socket.gethostname()
    packages = collect_packages(root, host)
    if not packages:
        sys.exit("No package declarations found")

    grouped = {}
    for channel, name in packages:
        grouped.setdefault(channel, []).append(name)

    print(f"Comparing {len(packages)} declarations across {len(grouped)} channel(s)...", file=sys.stderr)
    results = evaluate(lock_refs(root), grouped, args.refresh)

    use_color = not args.no_color and sys.stdout.isatty()
    sections = []
    total = 0
    for channel in CHANNEL_ORDER:
        if channel not in grouped:
            continue
        lines = render(channel, results_channel_entries(results, channel, packages), use_color, args.all)
        sections.append("\n".join(lines))
        total += sum(1 for l in lines[1:] if "-->" in l and "(up to date)" not in l)
    print("\n\n".join(sections))
    summary = "all up to date" if total == 0 else f"{total} update(s) available"
    print(f"\n{DIM}{summary}{RESET}" if use_color else f"\n{summary}")


def results_channel_entries(results, channel, packages):
    return {name: tuple(results[channel].get(name, (None, None))) for chan, name in packages if chan == channel}


if __name__ == "__main__":
    main()
