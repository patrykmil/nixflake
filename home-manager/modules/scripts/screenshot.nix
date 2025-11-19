{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "screencapture" ''
      #!/usr/bin/env bash

      GRIM="${pkgs.grim}/bin/grim"
      SLURP="${pkgs.slurp}/bin/slurp"
      WF="${pkgs.wf-recorder}/bin/wf-recorder"
      NOTIFY="${pkgs.libnotify}/bin/notify-send"

      outputDir="$HOME/Screencapture"
      mkdir -p "$outputDir"
      pidFile="/tmp/screencapture_record.pid"

      operation=$1
      mode=''${2:-area}

      case "$operation" in
        shot)
          case "$mode" in
            all)
              outputFile="screenshot_$(date +%Y-%m-%d_%H:%M:%S).png"
              outputPath="$outputDir/$outputFile"
              "$GRIM" "$outputPath" && \
              "$NOTIFY" -t 3000 -u normal \
                "Screenshot saved" "$outputPath"
              wl-copy < "$outputPath"
              ;;
            monitor)
              outputFile="screenshot_$(date +%Y-%m-%d_%H:%M:%S).png"
              outputPath="$outputDir/$outputFile"
              "$GRIM" -g "$("$SLURP" -o)" "$outputPath" && \
              "$NOTIFY" -t 3000 -u normal \
                "Screenshot saved" "$outputPath"
              wl-copy < "$outputPath"
              ;;
            area)
              outputFile="screenshot_$(date +%Y-%m-%d_%H:%M:%S).png"
              outputPath="$outputDir/$outputFile"
              "$GRIM" -g "$("$SLURP")" "$outputPath" && \
              "$NOTIFY" -t 3000 -u normal \
                "Screenshot saved" "$outputPath"
              wl-copy < "$outputPath"
              ;;
            *)
              echo "Invalid mode for shot: $mode"
              echo "Usage: $0 shot {all|monitor|area}"
              exit 1
              ;;
          esac
          ;;
        record)
          # Check if recording is active
          if [ -f "$pidFile" ]; then
            WF_PID=$(cat "$pidFile")
            if kill -0 "$WF_PID" 2>/dev/null; then
              kill "$WF_PID" 2>/dev/null
              "$NOTIFY" -t 3000 -u normal \
                "Recording stopped"
              rm -f "$pidFile"
              exit 0
            else
              rm -f "$pidFile"  # Remove stale PID file
            fi
          fi
          # Start new recording
          case "$mode" in
            all)
              recordFile="screencast_$(date +%Y-%m-%d_%H:%M:%S).mkv"
              recordPath="$outputDir/$recordFile"
              "$WF" -f "$recordPath" &
              WF_PID=$!
              echo $WF_PID > "$pidFile"
              "$NOTIFY" -t 3000 -u normal \
                "Recording started"
              ;;
            area)
              recordFile="screencast_$(date +%Y-%m-%d_%H:%M:%S).mkv"
              recordPath="$outputDir/$recordFile"
              geometry="$("$SLURP")"
              "$WF" -g "$geometry" -f "$recordPath" &
              WF_PID=$!
              echo $WF_PID > "$pidFile"
              "$NOTIFY" -t 3000 -u normal \
                "Recording started"
              ;;
            *)
              echo "Invalid mode for record: $mode"
              echo "Usage: $0 record {all|area}"
              exit 1
              ;;
          esac
          ;;
        *)
          echo "Invalid operation: $operation"
          echo "Usage: $0 {shot|record} [mode]"
          echo "Modes for shot: all, monitor, area"
          echo "Modes for record: all, area"
          exit 1
          ;;
      esac
    '')
  ];
}