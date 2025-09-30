{
  windowrule = [
    # "suppressevent maximize, class:.*"
    # "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
  ];
  windowrulev2 = [
    # "float, class:^(Alacritty)$"
    # "size 350 300, class:^(Alacritty)$"
    # "move 75% 69%, class:^(Alacritty)$"

    # "float, class:^(org\\.pulseaudio\\.pavucontrol)$"
    # "size 800 500, class:^(org\\.pulseaudio\\.pavucontrol)$"
    # "move 55% 50%, class:^(org\\.pulseaudio\\.pavucontrol)$"

    # Smart gaps/borders thingy part 2
    "bordersize 0, floating:0, onworkspace:w[tv1]"
    "rounding 0, floating:0, onworkspace:w[tv1]"
    "bordersize 0, floating:0, onworkspace:f[1]"
    "rounding 0, floating:0, onworkspace:f[1]"
  ];
}
