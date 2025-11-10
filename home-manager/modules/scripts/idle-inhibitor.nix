{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "idleInhibitor" ''
      #!/bin/bash

      STATUS_FILE=~/.config/idle_inhibit_status.txt

      if [ $# -eq 0 ]; then
          if [ -f "$STATUS_FILE" ]; then
              read start duration < "$STATUS_FILE"
              now=$(date +%s)
              elapsed=$((now - start))
              if [ $elapsed -lt $duration ]; then
                  left=$((duration - elapsed))
                  echo "Time left: $left seconds"
              else
                  echo "No active inhibition"
                  rm "$STATUS_FILE"
              fi
          else
              echo "No active inhibition"
          fi
      elif [ "$1" = "k" ]; then
          pkill -f "systemd-inhibit.*idle"
          rm -f "$STATUS_FILE"
          echo "Inhibition killed"
      else
          if [[ "$1" =~ ^[0-9]+$ ]]; then
              pkill -f "systemd-inhibit.*idle"
              systemd-inhibit --what=idle sleep "$1" &
              echo "$(date +%s) $1" > "$STATUS_FILE"
              echo "Inhibition set for $1 seconds"
          else
              echo "Invalid argument. Use a number for seconds, 'k' to kill, or no args to check."
          fi
      fi
    '')
  ];
}
