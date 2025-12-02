{
  pkgs,
  hostName,
  inputs,
  ...
}:
let
  wifitui = inputs.wifitui.packages.${pkgs.system}.default;
  antigravity = inputs.antigravity-nix.packages.${pkgs.system}.default;
in
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
      wifitui
      appimage-run

      pavucontrol
      pamixer
      geeqie
      celluloid
      alacritty
      vscode-fhs
      antigravity

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
