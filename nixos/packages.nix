{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    wezterm
    git
    fzf
    zoxide
    eza
    helix
    bat
    kdePackages.kate
    kdePackages.breeze-icons
    pcmanfm
    bibata-cursors
    nwg-look
    vscode
    brave
    home-manager
    hyprland
    hypridle
    hyprpanel
    hyprlock
    xdg-desktop-portal-hyprland
    xdg-utils
    wl-clipboard
    grim
    slurp
    wofi
    gammastep
    python314
    wlogout
  ];

  fonts.packages = with pkgs; [
    meslo-lg
    meslo-lgs-nf
  ];
}
