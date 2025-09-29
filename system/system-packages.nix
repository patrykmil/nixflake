{
  pkgs,
  hostName,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages =
    with pkgs;
    [
      pcmanfm
      nwg-look
      brave
      home-manager
      wl-clipboard
      grim
      slurp
      python313
      ruff
      sqlite
      # qogir-icon-theme

      # For Dank Material Shell
      libnotify
      xdg-desktop-portal-gtk
      mate.mate-polkit
      jq
      xwayland-satellite
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
    material-symbols
    inter
    fira-code
  ];
}
