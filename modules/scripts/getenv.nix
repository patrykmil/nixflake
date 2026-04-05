{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "getenv" ''
      #!/usr/bin/env bash

      if [ -z "$1" ]; then
        echo "Usage: $0 <environment>"
        exit 1
      fi

      SCRIPT_DIR="$HOME/moreflakes"

      matches=()
      for d in "$SCRIPT_DIR"/*/; do
        name="$(basename "$d")"
        if [[ "$name" == "$1"* ]]; then
          matches+=("$name")
        fi
      done

      if [ ''${#matches[@]} -eq 0 ]; then
        echo "Error: no environment matching '$1'"
        exit 1
      elif [ ''${#matches[@]} -gt 1 ]; then
        echo "Error: '$1' matches multiple environments: ''${matches[*]}"
        exit 1
      fi

      DIR="$SCRIPT_DIR/''${matches[0]}"

      cp "$DIR"/flake* . 2>/dev/null
      cp "$DIR"/.gitignore . 2>/dev/null

      if [ -f "$DIR/enter.sh" ]; then
        exec bash "$DIR/enter.sh"
      else
        echo "Error: '$DIR/enter.sh' not found"
        exit 1
      fi

    '')
  ];
}
