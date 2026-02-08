{ config, lib, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = "on";
      wallpaper = lib.mkDefault {
        monitor = "";
        path = "${flakeDir}/wallpapers/pacman-nord.jpg";
      };
    };
  };
}
