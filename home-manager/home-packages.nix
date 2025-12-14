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
      # antigravity

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
