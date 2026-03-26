{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "screencapture" ''
      #!/usr/bin/env bash

      GRIM="${pkgs.grim}/bin/grim"
      SLURP="${pkgs.slurp}/bin/slurp"
      WF="${pkgs.wf-recorder}/bin/wf-recorder"
      NOTIFY="${pkgs.libnotify}/bin/notify-send"
      TESSERACT="${pkgs.tesseract}/bin/tesseract"

      outputDir="$HOME/Screencapture"
      mkdir -p "$outputDir"
      pidFile="/tmp/screencapture_record.pid"

      operation=$1
      subcommand=$2
      language=''${3:-eng}
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
        extract)
          if [ "$subcommand" != "area" ]; then
            echo "Invalid subcommand for extract: $subcommand"
            echo "Usage: $0 extract area {eng|pl}"
            exit 1
          fi

          outputFile="$(mktemp).png"
          geometry="$("$SLURP")"
          "$GRIM" -g "$geometry" "$outputFile" || exit 1

          case "$language" in
            eng)
              ocrText="$("$TESSERACT" "$outputFile" stdout 2>/dev/null)" && \
              echo -n "$ocrText" | wl-copy
              ;;
            pl)
              ocrText="$("$TESSERACT" -l pol "$outputFile" stdout 2>/dev/null)"
              if [ $? -eq 0 ]; then
                echo -n "$ocrText" | wl-copy
              else
                "$NOTIFY" -t 3000 -u critical \
                  "OCR failed - Polish language pack may not be installed"
              fi
              ;;
            *)
              echo "Invalid language: $language"
              echo "Usage: $0 extract area {eng|pl}"
              rm -f "$outputFile"
              exit 1
              ;;
          esac

          rm -f "$outputFile"
          ;;
        *)
          echo "Invalid operation: $operation"
          echo "Usage: screencapture {shot|record|extract} [mode]"
          echo "Modes for shot: all, monitor, area"
          echo "Modes for record: all, area"
          echo "Modes for extract: area {eng|pl}"
          exit 1
          ;;
      esac
    '')
  ];
}
