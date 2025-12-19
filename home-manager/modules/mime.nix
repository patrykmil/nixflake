{ config, pkgs, hostName, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "brave.desktop" ];
      "text" = [ "code.desktop" ];
    };
  };

  home.sessionVariables = {
    EDITOR = "code";
    TERMINAL = if hostName == "desktop" then "wezterm" else "alacritty";
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = if hostName == "desktop" then ["wezterm.desktop"] else ["alacritty.desktop"];
    };
  };
}
