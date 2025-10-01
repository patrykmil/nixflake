{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "monitorToggle" ''
      #!/usr/bin/env bash

      NOTIFY="${pkgs.libnotify}/bin/notify-send"

      HDMI="HDMI-A-1"
      DP="DP-2"

      if hyprctl monitors | grep -q "$HDMI"; then
          hyprctl dispatch dpms off "$HDMI"
          hyprctl keyword monitor "$HDMI,disable"

          "$NOTIFY" -t 5000 -u normal \
          "Monitor disabled" "$HDMI"
      else
          hyprctl keyword monitor "$HDMI,1920x1080@60,0x0,1"
          hyprctl dispatch dpms on "$HDMI"
          "$NOTIFY" -t 5000 -u normal \
          "Monitor enabled" "$HDMI"
      fi
    '')
  ];
}
