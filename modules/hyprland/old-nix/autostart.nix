{ pkgs, hostClass, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprsunset"
      "noctalia"
      "wallpaperSchedule"
    ]
    ++ (
      if hostClass == "desktop" then
        [
          "sleep 1 && bright 50 4000"
        ]
      else if hostClass == "laptop" then
        [
          "sleep 1 && bright 100 4600"
        ]
      else
        [

        ]
    );
  };
}
