{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "screenshot" ''
      #!/usr/bin/env bash

      GRIM="${pkgs.grim}/bin/grim"
      SLURP="${pkgs.slurp}/bin/slurp"
      NOTIFY="${pkgs.libnotify}/bin/notify-send"

      outputDir="$HOME/Pictures/Screenshots"
      outputFile="screenshot_$(date +%Y-%m-%d_%H:%M:%S).png"
      outputPath="$outputDir/$outputFile"
      mkdir -p "$outputDir"

      mode=''${1:-area}

      case "$mode" in
      all)
          "$GRIM" "$outputPath" && \
          "$NOTIFY" -t 3000 -u normal \
            "Screenshot saved" "$outputPath"
          wl-copy < "$outputPath"
          ;;
      monitor)
          "$GRIM" -g "$("$SLURP" -o)" "$outputPath" && \
          "$NOTIFY" -t 3000 -u normal \
            "Screenshot saved" "$outputPath"
          wl-copy < "$outputPath"
          ;;
      area)
          "$GRIM" -g "$("$SLURP")" "$outputPath" && \
          "$NOTIFY" -t 3000 -u normal \
            "Screenshot saved" "$outputPath"
          wl-copy < "$outputPath"
          ;;
      *)
          echo "Invalid option: $mode"
          echo "Usage: $0 {all|monitor|area}"
          exit 1
          ;;
      esac
    '')
  ];
}

# --action="xdg-open $outputDir=Directory" \
# --action="xdg-open $outputPath=View"
