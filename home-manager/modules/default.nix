{
  imports = [
    ./hyprland/hyprland.nix

    ./shell/fish.nix
    ./shell/bat/bat.nix
    ./shell/eza.nix

    ./bar/waybar/waybar.nix
    ./bar/hyprpanel/hyprpanel.nix

    ./scripts/set-scripts.nix

    ./launcher/wofi.nix
    ./launcher/wofi-power-menu.nix

    ./wallpaper/hyprpaper.nix

    ./helix.nix
    ./wezterm.nix
    ./gtk.nix
    ./gammastep.nix
    ./git.nix
  ];
}
