let
  wallpaperFolder = builtins.toString ./wallpapers;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
    };
  };
}
