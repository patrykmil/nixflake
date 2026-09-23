{ hostClass, hostMonitors, ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      {
        name = "windowrule-1";
        suppress_event = "maximize";
        "match:class" = ".*";
      }
      {
        name = "windowrule-2";
        no_focus = "on";
        "match:class" = "^$";
        "match:title" = "^$";
        "match:xwayland" = "1";
        "match:float" = "1";
        "match:fullscreen" = "0";
        "match:pin" = "0";
      }
      {
        name = "windowrule-3";
        border_size = "0";
        rounding = "0";
        "match:float" = "0";
        "match:workspace" = "w[tv1]";
      }
      {
        name = "windowrule-4";
        border_size = "0";
        rounding = "0";
        "match:float" = "0";
        "match:workspace" = "f[1]";
      }
      {
        name = "windowrule-emulator";
        float = "on";
        "match:class" = "^(Emulator)$";
      }
      {
        name = "windowrule-waydroid";
        float = "on";
        "match:class" = "(?i).*waydroid.*";
      }
    ]
    ++ (
      if hostClass == "desktop" then
        [
          {
            name = "windowrule-pwvucontrol";
            float = "on";
            size = "1060 570";
            move = "(850) (470)";
            "match:class" = "^(com\\.saivert\\.pwvucontrol)$";
          }
          {
            name = "windowrule-wifitui";
            float = "on";
            size = "600 720";
            move = "(1315) (315)";
            "match:class" = "^(wifitui)$";
          }
          {
            name = "windowrule-localsend";
            float = "on";
            size = "700 900";
            center = "on";
            "match:class" = "^(localsend_app)$";
          }
        ]
      else
        [ ]
    );

    workspace = [
      "w[tv1],gapsin:0, gapsout:0"
      "f[1],gapsin:0, gapsout:0"
    ]
    ++ (
      if hostClass == "desktop" then
        [
          "1,monitor:${hostMonitors.primary}"
        ]
      else
        [ ]
    );
  };
}
