{ hostName, ... }:
{
  monitor = [
    "DP-2,1920x1080@165,0x0,1"
    "HDMI-A-1,disable"
  ];

  workspace = (if hostName == "desktop" then [ "1,monitor:DP-2" ] else [ ]) ++ [
    # Smart gaps/borders thingy part 1
    "w[tv1],gapsin:0, gapsout:0"
    "f[1],gapsin:0, gapsout:0"
  ];
}
