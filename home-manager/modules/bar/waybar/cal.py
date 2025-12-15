#!/usr/bin/env python3
import calendar
import datetime
import json
import os
import re

now = datetime.datetime.now()

palette_path = os.path.expanduser("~/.config/stylix/palette.json")
try:
    with open(palette_path, "r") as f:
        palette = json.load(f)
    colors = {k: f"#{v}" for k, v in palette.items() if k.startswith("base")}
except Exception:
    colors = {
        "base00": "#191724",
        "base01": "#1f1d2e",
        "base02": "#26233a",
        "base03": "#6e6a86",
        "base04": "#908caa",
        "base05": "#e0def4",
        "base06": "#e0def4",
        "base07": "#524f67",
        "base08": "#eb6f92",
        "base09": "#f6c177",
        "base0A": "#ebbcba",
        "base0B": "#31748f",
        "base0C": "#9ccfd8",
        "base0D": "#c4a7e7",
        "base0E": "#f6c177",
        "base0F": "#524f67",
    }

FG_BAR = colors["base05"]
FG_MONTH = colors["base05"]
FG_WEEKDAY = colors["base05"]
FG_TITLE = colors["base0E"]
FG_DAY_NAME = colors["base0E"]
FG_WEEKEND = colors["base0D"]
FG_TODAY = colors["base08"]
FG_LINE = colors["base04"]

FONT_SIZE = 11
MONTH_WIDTH = 20
COLUMNS = 2
SPACING = 2
DAYS_IN_WEEK = 7


def strip_markup(s):
    return re.sub(r"<.*?>", "", s)


def format_day(d, i, m):
    if d == 0:
        return "  "
    elif d == now.day and m == now.month:
        return f"<span foreground='{FG_TODAY}'><b>{d:2}</b></span>"
    elif i in (5, 6):
        return f"<span foreground='{FG_WEEKEND}'>{d:2}</span>"
    else:
        return f"<span foreground='{FG_WEEKDAY}'>{d:2}</span>"


def month_calendar(m, y):
    cal = calendar.Calendar()
    month_name = (
        f"<span foreground='{FG_TODAY}'><b>{calendar.month_name[m]} {y}</b></span>"
        if m == now.month
        else f"<span foreground='{FG_MONTH}'>{calendar.month_name[m]} {y}</span>"
    )
    headers = " ".join(
        [f"<span foreground='{FG_DAY_NAME}'>{d}</span>" for d in ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]]
    )
    lines = [month_name]
    lines.append(f"<span foreground='{FG_LINE}'>{'─' * MONTH_WIDTH}</span>")
    lines.append(headers)
    for week in cal.monthdayscalendar(y, m):
        line = [format_day(d, i, m) for i, d in enumerate(week)]
        lines.append(" ".join(line))
    return lines


months = []
month_list = []

start_month = now.month - 2
start_year = now.year

if start_month < 1:
    start_month += 12
    start_year -= 1

for i in range(6):
    m = start_month + i
    y = start_year
    if m > 12:
        m -= 12
        y += 1
    months.append(month_calendar(m, y))
    month_list.append((m, y))

tooltip_lines = []

top_line = f"{now.strftime('%A, %d %B %Y')}"
tooltip_lines.append(f"<span foreground='{FG_TITLE}'>{top_line}</span>")
tooltip_lines.append("")

for row in range(0, 6, COLUMNS):
    month_block_lines = [months[row + i] for i in range(COLUMNS)]
    max_lines = max(len(b) for b in month_block_lines)
    for l in range(max_lines):
        parts = []
        for b in month_block_lines:
            if l < len(b):
                stripped = len(strip_markup(b[l]))
                pad = MONTH_WIDTH - stripped
                parts.append(b[l] + " " * pad)
            else:
                parts.append(" " * MONTH_WIDTH)
        tooltip_lines.append(f"<span font='{FONT_SIZE}'>{(' ' * SPACING).join(parts)}</span>")
    tooltip_lines.append("")

text = f"<span foreground='{FG_BAR}'>{now.strftime('%H:%M  ')}</span>"

tooltip_text = "\n".join(tooltip_lines)
output = {"text": text, "tooltip": f"<span>{tooltip_text}</span>", "markup": "pango"}

print(json.dumps(output))
