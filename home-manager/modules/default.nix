{ hostName, ... }:
{
  imports =
    [
      ./hyprland/hyprland.nix
      ./hypridle.nix

      ./shell/fish.nix
      ./shell/bat/bat.nix
      ./shell/eza.nix
      ./shell/direnv.nix

      ./bar/waybar/waybar.nix
      ./bar/hyprpanel/hyprpanel.nix

      ./scripts/set-scripts.nix

      ./launcher/rofi.nix
      ./launcher/wofi.nix
      ./launcher/wofi-power-menu.nix

      ./hyprpaper.nix

      ./helix.nix
      ./wezterm.nix
      ./gammastep.nix
      ./git.nix

      ./stylix.nix
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
