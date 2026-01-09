{ hostName, ... }:
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
        name = "windowrule-5";
        float = "on";
        "match:class" = "^(Emulator)$";
      }
    ]
    ++ (
      if hostName == "desktop" then
        [
          {
            name = "windowrule-6";
            float = "on";
            size = "1060 570";
            move = "(850) (470)";
            "match:class" = "^(com\\.saivert\\.pwvucontrol)$";
          }
          {
            name = "windowrule-7";
            float = "on";
            size = "600 720";
            move = "(1315) (315)";
            "match:class" = "^(wifitui)$";
          }
          {
            name = "windowrule-8";
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
      if hostName == "desktop" then
        [
          "1,monitor:DP-2"
        ]
      else
        [ ]
    );
  };
}
