{ hostName, hostMonitors, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "${hostMonitors.primary},1920x1080@165,0x0,1"
      "${hostMonitors.secondary},disable"
    ];

    workspace = (if hostName == "desktop" then [ "1,monitor:${hostMonitors.primary}" ] else [ ]) ++ [
      # Smart gaps/borders thingy part 1
      "w[tv1],gapsin:0, gapsout:0"
      "f[1],gapsin:0, gapsout:0"
    ];
  };
}
