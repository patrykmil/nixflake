{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    pcmanfm
    nwg-look
    vscode
    brave
    home-manager
    wl-clipboard
    grim
    grimblast
    slurp
    python314
  ];

  fonts.packages = with pkgs; [
    meslo-lg
    meslo-lgs-nf
  ];
}
