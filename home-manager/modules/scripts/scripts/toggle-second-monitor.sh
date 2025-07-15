#!/usr/bin/env bash

HDMI="HDMI-A-1"
DP="DP-2"

if hyprctl monitors | grep -q "$HDMI"; then
    hyprctl dispatch dpms off "$HDMI"
    hyprctl keyword monitor "$HDMI,disable"
else
    hyprctl keyword monitor "$HDMI,1920x1080@60,0x0,1"
    hyprctl dispatch dpms on "$HDMI"
fi
