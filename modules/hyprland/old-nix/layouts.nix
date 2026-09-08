{
  wayland.windowManager.hyprland.settings = {
    dwindle = {
      preserve_split = true;
      force_split = 2;
    };

    master = {
      new_status = "slave";
      new_on_active = "before";
    };

    scrolling = {
      column_width = 0.6;
      focus_fit_method = 0;
      follow_min_visible = 0.1;
    };
  };
}
