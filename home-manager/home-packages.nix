{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    nixfmt-rfc-style
    networkmanagerapplet
    mako
    pulseaudio
    pamixer
    pavucontrol
    alacritty
    geeqie
    hyprpicker
    hyprpaper
  ];
}
