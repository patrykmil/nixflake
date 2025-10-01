{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "bright" ''
      #!/usr/bin/env bash

      SWITCH="${pkgs.hyprsunset}/bin/hyprsunset"

      if pgrep -x hyprsunset > /dev/null; then
        pkill -x hyprsunset
      fi

      sleep 1

      if [ -n "$1" ]; then
        nohup "$SWITCH" -g "$1"
      else
        echo "Usage: bright <gamma-value>"
        exit 1
      fi

    '')
  ];
}
