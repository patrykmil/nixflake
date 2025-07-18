{ pkgs, ... }:
{
  exec-once = [
    "${pkgs.waybar}/bin/waybar"
    "hyprctl dispatch movecursor 2880 540"
    "hyprpaper"
  ];
}
