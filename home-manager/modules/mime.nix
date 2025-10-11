{ config, pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "brave-browser.desktop" ];
      "text" = [ "code.desktop" ];
    };
  };
}
