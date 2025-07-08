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

    home-manager
  ];
}
