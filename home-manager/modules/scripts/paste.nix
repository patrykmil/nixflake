{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "plainpaste" ''
      #!/usr/bin/env bash
      set -euo pipefail

      WLPASTE="${pkgs.wl-clipboard}/bin/wl-paste"
      WLCOPY="${pkgs.wl-clipboard}/bin/wl-copy"
      WTYPE="${pkgs.wtype}/bin/wtype"

      "$WLPASTE" --type text/plain | "$WTYPE" -

    '')
  ];
}
