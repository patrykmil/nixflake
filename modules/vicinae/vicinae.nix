{
  pkgs,
  config,
  lib,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  xdg.configFile."vicinae/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/vicinae/vicinae.jsonc";
}
