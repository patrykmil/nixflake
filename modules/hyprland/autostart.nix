{ pkgs, hostName, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
    ]
    ++ (
      if hostName == "desktop" then
        [
          "sleep 1 && bright 50 4000"
        ]
      else if hostName == "laptop" then
        [
          "sleep 1 && bright 100 4600"
        ]
      else
        [

        ]
    );
  };
}
