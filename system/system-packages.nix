{ pkgs, hostName, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages =
    with pkgs;
    [
      pcmanfm
      nwg-look
      # vscode
      brave
      home-manager
      wl-clipboard
      grim
      slurp
      python314
      ruff
      sqlite
      qogir-icon-theme
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

  fonts.packages = with pkgs; [
    maple-mono.NF
    noto-fonts
    nerd-fonts.caskaydia-mono
    nerd-fonts.meslo-lg
    nerd-fonts.arimo
    excalifont
  ];
}
