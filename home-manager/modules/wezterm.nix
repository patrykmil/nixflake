{
  pkgs,
  hostName,
  fonts,
  ...
}:

{
  programs.wezterm = {
    enable = true;

    # command_palette_bg_color = "#171922",
    # command_palette_fg_color = "#E4F0FB",
    # enable_scroll_bar = true,
    # tab_bar_at_bottom = true,

    extraConfig = ''
      return {
        font = wezterm.font("${fonts.monospace}"),
        color_scheme = "Poimandres",
        command_palette_rows = 5,
        window_close_confirmation = "NeverPrompt",
        use_fancy_tab_bar = false,
        hide_tab_bar_if_only_one_tab = true,
        tab_max_width = 25,

        ${
          if hostName == "desktop" then
            ''
              enable_scroll_bar = true,
              tab_bar_at_bottom = true,
            ''
          else
            "         
              font_size = 12;
            "
        }

        keys = {
          { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab "DefaultDomain" },
          { key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentTab { confirm = false } },
          { key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
          { key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
          { key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
          { key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
          { key = "p", mods = "CTRL", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
          { key = "n", mods = "CTRL", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
          { key = "q", mods = "CTRL", action = wezterm.action.CloseCurrentPane { confirm = false } },
          { key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left" },
          { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right" },
          { key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up" },
          { key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down" },
          { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom "Clipboard" },
        },
      }
    '';
  };
}
# colors = {
#   tab_bar = {
#     background = "#0b0022",
#     active_tab = {
#       bg_color = "#506477",
#       fg_color = "#E4F0FB",
#     },
#     inactive_tab = {
#       bg_color = "#1B1E28",
#       fg_color = "#A4A0AB",
#     },
#     inactive_tab_hover = {
#       bg_color = "#42675A",
#       fg_color = "#C4C0CB",
#     },
#     new_tab = {
#       bg_color = "#0b0022",
#       fg_color = "#A4A0AB",
#     },
#     new_tab_hover = {
#       bg_color = "#0b0022",
#       fg_color = "#FCC5E9",
#     },
#   },
# },
