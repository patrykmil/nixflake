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
      nixfmt
      bun
      python313

      brave

      hyprsunset
      hyprpicker
      grim
      slurp

      nix-tree
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
      trashy
      nethogs

      geeqie
      celluloid
      alacritty
      vscode-fhs
      opencode

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

  xdg.desktopEntries =
    if hostName == "laptop" then
      {
        code = {
          name = "Visual Studio Code (Wayland)";
          exec = "env ELECTRON_ENABLE_WAYLAND=1 GDK_BACKEND=wayland code --ozone-platform=wayland --new-window";
          categories = [
            "Utility"
            "TextEditor"
            "Development"
            "IDE"
          ];
          comment = "Code Editing. Redefined.";
          genericName = "Text Editor";
          icon = "vscode";
          type = "Application";
          startupNotify = true;
        };
      }
    else
      { };
}
