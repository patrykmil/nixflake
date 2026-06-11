{
  config,
  pkgs,
  hostName,
  ...
}:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "brave-browser.desktop" ];
      "text/" = [
        "code.desktop"
        "Helix.desktop"
      ];
      "image/" = [ "org.geeqie.Geeqie.desktop" ];

      "inode/directory" = [ "nemo.desktop" ];
      "application/x-gnome-saved-search" = [ "nemo.desktop" ];

      "video/" = [ "io.github.diegopvlk.Cine.desktop" ];
      "audio/" = [ "io.github.diegopvlk.Cine.desktop" ];
    };
  };

  home.sessionVariables = {
    EDITOR = "code --wait";
    TERMINAL = "wezterm";
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "wezterm.desktop" ];
    };
  };

  dconf = {
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "wezterm";
      };
    };
  };
}
