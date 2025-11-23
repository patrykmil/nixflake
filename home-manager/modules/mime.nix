{ config, pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "brave.desktop" ];
      "text" = [ "code.desktop" ];
    };
  };
}
