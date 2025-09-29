{
  monitor = [
    "DP-2,1920x1080@165,1920x0,1"
    "HDMI-A-1,disable"
  ];

  workspace = [
    "1,monitor:DP-2"
    # Smart gaps/borders thingy part 1
    "w[tv1],gapsin:0, gapsout:0 0 16 0"
    "f[1],gapsin:0, gapsout:0 0 16 0"
  ];
}
