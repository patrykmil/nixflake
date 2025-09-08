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
      bun
      peazip
      btop
      ripgrep
      fd
      localsend
      prusa-slicer
      unzip
    ]
    ++ (
      if hostName == "desktop" then
        [
          jetbrains.pycharm-professional
          ffmpeg-full
          vscode
        ]
      else if hostName == "laptop" then
        [
          brightnessctl
          libgcc
          vscode-fhs
          arduino-ide
        ]
      else
        [

        ]
    );
}
