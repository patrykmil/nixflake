{ hostClass, hostMonitors, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2,1920x1080@165,0x0,1"
      "HDMI-A-1,disable"
      "eDP-1,1920x1080@60,0x0,1.2"
    ];

    workspace = (if hostClass == "desktop" then [ "1,monitor:${hostMonitors.primary}" ] else [ ]) ++ [
      # Smart gaps/borders thingy part 1
      "w[tv1],gapsin:0, gapsout:0"
      "f[1],gapsin:0, gapsout:0"
    ];
  };
}
