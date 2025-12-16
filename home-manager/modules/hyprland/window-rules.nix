{ hostName, ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
    windowrulev2 = [
      # Smart gaps/borders thingy part 2
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"

      "float, class:^(Emulator)$"
    ]
    ++ (
      if hostName == "desktop" then
        [
          "float, class:^(org\\.pulseaudio\\.pavucontrol)$"
          "size 1060 570, class:^(org\\.pulseaudio\\.pavucontrol)$"
          "move 850 470, class:^(org\\.pulseaudio\\.pavucontrol)$"

          "float, class:^(wifitui)$"
          "size 600 720, class:^(wifitui)$"
          "move 1315 315, class:^(wifitui)$"

          "float, class:^(localsend_app)$"
          "size 700 900, class:^(localsend_app)$"
          "center, class:^(localsend_app)$"
        ]
      else
        [ ]
    );
  };
}
