{ pkgs, hostName, ... }:
{
  exec-once = [
    # "hyprctl dispatch movecursor 2880 540"
    # "dms run"
    "waybar"
  ]
  ++ (
    if hostName == "desktop" then
      [
        "hyprsunset -g 67"
      ]
    else if hostName == "laptop" then
      [
      ]
    else
      [

      ]
  );
}
