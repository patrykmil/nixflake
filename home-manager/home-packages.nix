{
  pkgs,
  hostName,
  inputs,
  ...
}:
let
  wifitui = inputs.wifitui.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages =
    with pkgs;
    [
      nixfmt-rfc-style
      bun
      python313

      hyprsunset
      hyprpicker
      grim
      slurp

      btop
      fastfetch
      ripgrep
      fd
      unzip
      zip
      wget
      tldr
      mtr
      wl-clipboard
      wifitui
      playerctl
      pavucontrol
      pamixer
      appimage-run

      geeqie
      celluloid
      alacritty
      vscode-fhs

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
          teams-for-linux
          devenv
          # floorp-bin
        ]
      else if hostName == "laptop" then
        [
          bluetuith
          brightnessctl
        ]
      else
        [

        ]
    );
}
