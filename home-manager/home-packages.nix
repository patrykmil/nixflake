{ pkgs, hostName, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
      # mako
      # pulseaudio
      # pamixer
      # pavucontrol
      # alacritty
      # networkmanagerapplet
      # hyprpaper
      # peazip
      fastfetch
      nixfmt-rfc-style
      geeqie
      hyprsunset
      hyprpicker
      bun
      btop
      ripgrep
      fd
      localsend
      unzip
      xarchiver
      wget
      appimage-run
      vscode-fhs
      alacritty
      # Libre office and spelling dictionaries
      libreoffice-still
      hunspell
      hunspellDicts.pl_PL
      hunspellDicts.en_US
    ]
    ++ (
      if hostName == "desktop" then
        [
          # file
          jetbrains.pycharm-professional
          ffmpeg-full
          toybox
        ]
      else if hostName == "laptop" then
        [
          # brightnessctl
          # libgcc
        ]
      else
        [

        ]
    );
}
