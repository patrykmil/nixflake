{ config, pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "helium.desktop" ];
      "text" = [ "code.desktop" ];
    };
  };
}
