{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "bright" ''
      #!/usr/bin/env bash

      CONFIG_FILE="$HOME/.config/brightness.txt"

      touch "$CONFIG_FILE"

      if [ -n "$1" ]; then
        echo "$1" > "$CONFIG_FILE"
        gamma="$1"
      else
        if [ -s "$CONFIG_FILE" ]; then
          gamma=$(cat "$CONFIG_FILE")
        else
          echo "No brightness value in $CONFIG_FILE and no argument provided."
          exit 1
        fi
      fi
      hyprctl hyprsunset gamma "$gamma" > /dev/null 2>&1 &
    '')
  ];
}