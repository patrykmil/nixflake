{ hostName, ... }:
{
  imports = [
    ./hyprland/hyprland.nix
    ./hypridle.nix
    ./hyprpaper.nix
    # ./dank-material-shell.nix
    ./notifications.nix

    # ./wezterm.nix
    ./shell.nix
    ./helix.nix
    ./git.nix

    ./bar/waybar/waybar.nix
    # ./bar/hyprpanel/hyprpanel.nix

    ./scripts/script-modules.nix

    # ./launcher/rofi.nix
    # ./launcher/wofi.nix
    # ./launcher/wofi-power-menu.nix
    ./vicinae.nix

    # ./gammastep.nix

    ./stylix.nix

    ./webapps.nix
    ./mime.nix
  ]
  ++ (
    if hostName == "desktop" then
      [
        # ./helium.nix
      ]
    else if hostName == "laptop" then
      [

      ]
    else
      [

      ]
  );
}
