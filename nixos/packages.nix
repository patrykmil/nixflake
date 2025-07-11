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
    vscode
    firefox
    home-manager
    hyprland
    hypridle
    hyprpanel
    xdg-desktop-portal-hyprland
    xdg-utils
    wl-clipboard
    mako
    grim
    slurp
    wofi
    walker
  ];

  fonts.packages = with pkgs; [
    meslo-lg
    meslo-lgs-nf
  ];
}
