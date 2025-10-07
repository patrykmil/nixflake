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
      home-manager
      pcmanfm
      brave

      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-utils
      xwayland-satellite

      pipewire
      wireplumber

      # For Dank Material Shell
      libnotify
      jq
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
  ];
}
