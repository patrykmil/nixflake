let
  wallpaperFolder = builtins.toString ./wallpapers;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      preload = [
        "${wallpaperFolder}/ink_wave.png"
      ];

      wallpaper = [
        ",${wallpaperFolder}/ink_wave.png"
      ];
    };
  };
}
