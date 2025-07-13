{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    nixfmt-rfc-style
    networkmanagerapplet
    mako
    waybar
  ];
}
