{
  "$mainMod" = "SUPER";

  binds = {
    allow_workspace_cycles = true;
    workspace_back_and_forth = true;
  };

  bind = [
    "$mainMod,T,exec,alacritty"
    "$mainMod,Q,killactive,"
    "$mainMod,E,exec,pcmanfm"
    "$mainMod,F,togglefloating,"
    "$mainMod,R,exec,dms ipc call spotlight toggle"
    "$mainMod SHIFT,R,exec,dms ipc call powermenu toggle"
    "$mainMod,P,pseudo,"
    "$mainMod,J,togglesplit,"
    "$mainMod,B,exec,brave"
    "$mainMod,M,exec,hyprctl keyword general:layout master"
    "$mainMod,D,exec,hyprctl keyword general:layout dwindle"
    "$mainMod,left,movefocus,l"
    "$mainMod,right,movefocus,r"
    "$mainMod,up,movefocus,u"
    "$mainMod,down,movefocus,d"
    "$mainMod,1,focusworkspaceoncurrentmonitor,1"
    "$mainMod,2,focusworkspaceoncurrentmonitor,2"
    "$mainMod,3,focusworkspaceoncurrentmonitor,3"
    "$mainMod,4,focusworkspaceoncurrentmonitor,4"
    "$mainMod,5,focusworkspaceoncurrentmonitor,5"
    "$mainMod,6,focusworkspaceoncurrentmonitor,6"
    "$mainMod,7,focusworkspaceoncurrentmonitor,7"
    "$mainMod,8,focusworkspaceoncurrentmonitor,8"
    "$mainMod,9,focusworkspaceoncurrentmonitor,9"
    "$mainMod,0,focusworkspaceoncurrentmonitor,10"
    "$mainMod SHIFT,1,movetoworkspace,1"
    "$mainMod SHIFT,2,movetoworkspace,2"
    "$mainMod SHIFT,3,movetoworkspace,3"
    "$mainMod SHIFT,4,movetoworkspace,4"
    "$mainMod SHIFT,5,movetoworkspace,5"
    "$mainMod SHIFT,6,movetoworkspace,6"
    "$mainMod SHIFT,7,movetoworkspace,7"
    "$mainMod SHIFT,8,movetoworkspace,8"
    "$mainMod SHIFT,9,movetoworkspace,9"
    "$mainMod SHIFT,0,movetoworkspace,10"
    "$mainMod,mouse_down,workspace,e+1"
    "$mainMod,mouse_up,workspace,e-1"
    # Screenshots
    ",print,exec, screenshot all"
    "$mainMod SHIFT,S,exec, screenshot area"
    "$mainMod SHIFT,C,exec,hyprpicker -a -q -r"
    "Alt,Tab,workspace,previous"
  ];

  bindm = [
    "$mainMod,mouse:272,movewindow"
    "$mainMod,mouse:273,resizewindow"
  ];

  bindel = [
    ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp,exec,brightnessctl -e4 -n2 set 5%+"
    ",XF86MonBrightnessDown,exec,brightnessctl -e4 -n2 set 5%-"
  ];

  bindl = [
    ",XF86AudioNext,exec,playerctl next"
    ",XF86AudioPause,exec,playerctl play-pause"
    ",XF86AudioPlay,exec,playerctl play-pause"
    ",XF86AudioPrev,exec,playerctl previous"
  ];
}
