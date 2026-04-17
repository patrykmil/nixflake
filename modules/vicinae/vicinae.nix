{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

  xdg.configFile."vicinae/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "/home/ptrk/flakes/modules/vicinae/vicinae.json";
}
