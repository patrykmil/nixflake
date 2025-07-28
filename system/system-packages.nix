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
    slurp
    python314
    ruff
    sqlite
  ];
}
