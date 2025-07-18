#!/usr/bin/env bash

outputDir="$HOME/Pictures/Screenshots/"
outputFile="screenshot_$(date +%Y-%m-%d_%H:%M:%S).png"
outputPath="$outputDir/$outputFile"
mkdir -p "$outputDir"

mode=${1:-area}

case "$mode" in
all)
    grim "$outputPath"
    ;;
monitor)
    grim -g "$(slurp -o)" "$outputPath"
    ;;
area)
    grim -g "$(slurp)" "$outputPath"
    ;;
*)
    echo "Invalid option: $mode"
    echo "Usage: $0 {all|monitor|area}"
    exit 1
    ;;
esac

# Rest for notifications
# if eval "$command"; then
# recentFile=$(find "$outputDir" -name 'screenshot_*.png' -printf '%T+ %p\n' | sort -r | head -n 1 | cut -d' ' -f2-)
#         -i video-x-generic \
#         -a "Grimblast" \
#         -t 7000 \
#         -u normal \
#         --action="scriptAction:-xdg-open $outputDir=Directory" \
#         --action="scriptAction:-xdg-open $recentFile=View"
# fi
