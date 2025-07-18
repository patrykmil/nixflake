{
  monitor = [
    "DP-2,1920x1080@165,1920x0,1"
    "HDMI-A-1,1920x1080@60,0x0,1"
  ];

  workspace = [
    "1,monitor:DP-2"
    # Smart gaps/borders thingy part 1
    "w[tv1],gapsout:0,gapsin:0"
    "f[1],gapsout:0,gapsin:0"
  ];
}
