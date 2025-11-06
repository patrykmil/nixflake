{
  "$mainMod" = "SUPER";

  binds = {
    allow_workspace_cycles = true;
    workspace_back_and_forth = true;
  };

  bind = [
    "$mainMod,T,exec,alacritty"
    "$mainMod,B,exec,brave"
    "$mainMod,E,exec,nautilus --new-window"

    "$mainMod,Q,killactive,"
    "$mainMod,F,togglefloating,"

    "$mainMod,R,exec, vicinae toggle"


    "$mainMod,TAB,hyprexpo:expo,toggle"

    "$mainMod,P,pseudo,"
    "$mainMod,J,togglesplit,"

    "$mainMod,M,exec,hyprctl keyword general:layout master"
    "$mainMod,D,exec,hyprctl keyword general:layout dwindle"
    "$mainMod,S,exec,hyprctl keyword general:layout scrolling"

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
    "$mainMod,F10,exec,pamixer -d 5"
    "$mainMod,F11,exec,pamixer -i 5"
  ];

  bindl = [
    ",F9,exec,pamixer -t"
    ",F12,exec,pamixer --default-source -t"
    "$mainMod,F6,exec,playerctl previous"
    "$mainMod,F7,exec,playerctl play-pause"
    "$mainMod,F8,exec,playerctl next"
  ];
}
