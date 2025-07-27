{ pkgs, hostName, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
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
      jetbrains.pycharm-professional
      bun
      dbeaver-bin
    ]
    ++ (
      if hostName == "desktop" then
        [
          jetbrains.pycharm-professional
          dbeaver-bin
        ]
      else if hostName == "laptop" then
        [

        ]
      else
        [

        ]
    );
}
