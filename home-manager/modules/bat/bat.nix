{
  config,
  lib,
  pkgs,
  ...
}:

let
  customTheme = ./pmndrs.tmTheme;
  themeName = "Poimandres";
in
{
  home.file.".config/bat/themes/pmndrs.tmTheme".source = customTheme;

  home.activation.bat-theme-cache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bat}/bin/bat cache --build
  '';

  home.sessionVariables = {
    BAT_THEME = themeName;
  };
}
