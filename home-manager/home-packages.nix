{
  pkgs,
  hostName,
  inputs,
  ...
}:
let
  wifitui = inputs.wifitui.packages.${pkgs.stdenv.hostPlatform.system}.default;
  zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages =
    with pkgs;
    [
      nixfmt-rfc-style
      bun
      python313

      brave

      hyprsunset
      hyprpicker
      grim
      slurp

      nix-tree
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
      pwvucontrol
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
          # floorp-bin
          toybox
          obs-studio
          teams-for-linux
          devenv
          krita
          zen-browser
          zed-editor-fhs
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
