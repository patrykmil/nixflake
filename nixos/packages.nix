{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    wezterm
    git
    zoxide
    eza
    helix
    bat
    kdePackages.kate
    vscode

    home-manager
  ];
}
