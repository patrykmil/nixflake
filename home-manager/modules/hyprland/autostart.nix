{ pkgs, hostName, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "hyprctl dispatch movecursor 2880 540"
      # "dms run"
      "waybar"
    ]
    ++ (
      if hostName == "desktop" then
        [
          "bright 67"
        ]
      else if hostName == "laptop" then
        [
        ]
      else
        [

        ]
    );
  };
}
