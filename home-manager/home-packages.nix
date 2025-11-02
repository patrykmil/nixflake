{ pkgs, hostName, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
      bun
      nixfmt-rfc-style
      python313

      hyprsunset
      hyprpicker
      grim
      slurp

      playerctl
      wl-clipboard
      fastfetch
      ripgrep
      btop
      fd
      unzip
      zip
      superfile
      lazygit
      wget
      appimage-run

      geeqie
      celluloid
      localsend
      xarchiver
      nautilus
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
          # jetbrains.pycharm-professional
          # ffmpeg-full
          toybox
          obs-studio
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
