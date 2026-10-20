{ pkgs, hostMonitors, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "monitorToggle" ''
      #!/usr/bin/env bash

      NOTIFY="${pkgs.libnotify}/bin/notify-send"
      HDMI="${hostMonitors.secondary}"
      PRIMARY="${hostMonitors.primary}"

      POS_LEFT="-1920x0"
      POS_RIGHT="1920x0"

      disable_monitor() {
          hyprctl eval "hl.monitor({ output = \"$HDMI\", disabled = true })"
          "$NOTIFY" -t 5000 -u normal "Monitor disabled" "$HDMI"
      }

      enable_monitor() {
          local pos="$1"
          hyprctl eval "hl.monitor({ output = \"$HDMI\", mode = \"1920x1080@60\", position = \"$pos\", scale = 1 })"
          if hyprctl monitors | grep -q "$HDMI"; then
            hyprctl eval "hl.dispatch(hl.dsp.dpms({ action = \"on\", monitor = \"$HDMI\" }))"
          fi
          "$NOTIFY" -t 5000 -u normal "Monitor enabled" "$HDMI"
      }

      case "$1" in
          left)
              enable_monitor "$POS_LEFT"
              ;;
          right)
              enable_monitor "$POS_RIGHT"
              ;;
          mirror)
              hyprctl eval "hl.monitor({ output = \"$HDMI\", mode = \"preferred\", position = \"auto\", scale = 1, mirror = \"$PRIMARY\" })"
              "$NOTIFY" -t 5000 -u normal "Monitor mirrored" "$HDMI"
              ;;
          toggle|"")
              if hyprctl monitors | grep -q "$HDMI"; then
                  disable_monitor
              else
                  enable_monitor "$POS_LEFT"
              fi
              ;;
          *)
              echo "Usage: monitorToggle [left|right|mirror|toggle]"
              exit 1
              ;;
      esac
    '')
  ];
}
