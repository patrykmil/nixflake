{ lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = "on";
      wallpaper = lib.mkDefault {
        monitor = "";
        path = "/home/ptrk/flakes/wallpapers/pacman-nord.jpg";
      };
    };
  };
}
