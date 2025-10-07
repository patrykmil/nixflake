{ hostName, ... }:
{
  imports =
    [
      ./hyprland/hyprland.nix
      # ./hypridle.nix
      # ./hyprpaper.nix
      ./dankMaterialShell.nix

      # ./wezterm.nix
      ./shell.nix
      ./helix.nix
      ./git.nix

      # ./bar/waybar/waybar.nix
      # ./bar/hyprpanel/hyprpanel.nix

      ./scripts/script-modules.nix

      # ./launcher/rofi.nix
      # ./launcher/wofi.nix
      # ./launcher/wofi-power-menu.nix

      # ./gammastep.nix

      ./stylix.nix

      # ./helium.nix

    ]
    ++ (
      if hostName == "desktop" then
        [

        ]
      else if hostName == "laptop" then
        [

        ]
      else
        [

        ]
    );
}
