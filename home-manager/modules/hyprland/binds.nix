{ hostName, ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$BROWSER" = "brave";
    "$TERMINAL" = "wezterm";
    "$FILES" = "nemo";

    binds = {
      allow_workspace_cycles = true;
      workspace_back_and_forth = true;
    };

    bind = [
      "SUPER,T,exec,$TERMINAL"
      "SUPER SHIFT,T,exec, [float] $TERMINAL"
      "SUPER,B,exec,$BROWSER"
      "SUPER,E,exec,$FILES"
      "SUPER,Y,exec,pkill waybar || nohup waybar > /dev/null 2>&1 &"
      "SUPER,N,exec,swaync-client -t"

      "SUPER,Q,killactive,"
      "SUPER,F,togglefloating,"
      "SUPER,P,pin,"

      "SUPER,R,exec, vicinae toggle"
      "SUPER,V,exec, vicinae vicinae://extensions/vicinae/clipboard/history"
      "SUPER,TAB,exec, vicinae vicinae://extensions/vicinae/wm/switch-windows"

      "SUPER,P,pseudo,"
      "SUPER,J,togglesplit,"

      "SUPER,M,exec,hyprctl keyword general:layout master"
      "SUPER,D,exec,hyprctl keyword general:layout dwindle"
      "SUPER,S,exec,hyprctl keyword general:layout scrolling"

      "SUPER,left,movefocus,l"
      "SUPER,right,movefocus,r"
      "SUPER,up,movefocus,u"
      "SUPER,down,movefocus,d"
      "SUPER,1,focusworkspaceoncurrentmonitor,1"
      "SUPER,2,focusworkspaceoncurrentmonitor,2"
      "SUPER,3,focusworkspaceoncurrentmonitor,3"
      "SUPER,4,focusworkspaceoncurrentmonitor,4"
      "SUPER,5,focusworkspaceoncurrentmonitor,5"
      "SUPER,6,focusworkspaceoncurrentmonitor,6"
      "SUPER,7,focusworkspaceoncurrentmonitor,7"
      "SUPER,8,focusworkspaceoncurrentmonitor,8"
      "SUPER,9,focusworkspaceoncurrentmonitor,9"
      "SUPER,0,focusworkspaceoncurrentmonitor,10"
      "SUPER SHIFT,1,movetoworkspace,1"
      "SUPER SHIFT,2,movetoworkspace,2"
      "SUPER SHIFT,3,movetoworkspace,3"
      "SUPER SHIFT,4,movetoworkspace,4"
      "SUPER SHIFT,5,movetoworkspace,5"
      "SUPER SHIFT,6,movetoworkspace,6"
      "SUPER SHIFT,7,movetoworkspace,7"
      "SUPER SHIFT,8,movetoworkspace,8"
      "SUPER SHIFT,9,movetoworkspace,9"
      "SUPER SHIFT,0,movetoworkspace,10"
      "SUPER,mouse_down,workspace,e+1"
      "SUPER,mouse_up,workspace,e-1"
      "Alt,Tab,workspace,previous"

      # Screenshots
      ",print,exec, screencapture shot all"
      "SUPER SHIFT,S,exec, screencapture shot area"
      "SUPER SHIFT,D,exec, screencapture record area"
      "SUPER SHIFT,C,exec,hyprpicker -a -q -r"
    ];

    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];

    bindel = [
      ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ];

    bindl = [
      ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",F9, exec, wpctl set-mute -p $(hyprctl activewindow -j | jq '.pid') toggle"
      ",F12,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86AudioPrev,exec,playerctl previous"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioNext,exec,playerctl next"
    ];
  };
}
