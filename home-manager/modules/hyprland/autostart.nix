{ pkgs, ... }:
{
  exec-once = [
    "hyprctl dispatch movecursor 2880 540"
    "waybar"
  ];
}
