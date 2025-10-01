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
      # nwg-look
      home-manager
      pcmanfm
      brave
      wl-clipboard
      grim
      slurp
      python313
      ruff
      sqlite

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
