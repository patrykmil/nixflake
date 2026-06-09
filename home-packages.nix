{
  pkgs,
  pkgs-unstable,
  pkgs-master,
  hostName,
  inputs,
  ...
}:
let
  zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  helium-browser = inputs.helium.packages.x86_64-linux.default;
in
{
  home.packages =
    let
      common-unstable = with pkgs-master; [
        brave
      ];

      common = with pkgs; [
        python313

        hyprsunset
        hyprpicker
        grim
        slurp

        nixfmt
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
        trashy
        nethogs
        puppeteer-cli

        qdirstat
        geeqie
        celluloid
        alacritty
        teams-for-linux

        libreoffice-still
        hunspell
        hunspellDicts.pl_PL
        hunspellDicts.en_US
      ];

      hostSpecific = {
        desktop = with pkgs; [
          toybox
          obs-studio
          devenv
          krita
          zen-browser
          helium-browser
          zed-editor-fhs
          megacmd
          httptoolkit
        ];
        laptop = with pkgs; [
          bluetuith
          brightnessctl
          wtype
        ];
      };
    in
    common ++ common-unstable ++ (hostSpecific.${hostName} or [ ]);

  xdg.desktopEntries =
    let
      commonDesktopEntries = {
        nemo = {
          name = "Nemo (Files)";
          exec = "nemo %U";
          icon = "folder";
          comment = "Access and organize files";
          terminal = false;
          type = "Application";
          categories = [
            "GNOME"
            "GTK"
            "Utility"
            "Core"
          ];
          mimeType = [
            "inode/directory"
            "application/x-gnome-saved-search"
          ];
          startupNotify = false;
        };
      };
      hostEntries = {
        laptop = {
          #   code = {
          #     name = "Visual Studio Code (Wayland)";
          #     exec = "env ELECTRON_ENABLE_WAYLAND=1 GDK_BACKEND=wayland code --ozone-platform=wayland --new-window";
          #     categories = [
          #       "Utility"
          #       "TextEditor"
          #       "Development"
          #       "IDE"
          #     ];
          #     comment = "Code Editing. Redefined.";
          #     genericName = "Text Editor";
          #     icon = "vscode";
          #     type = "Application";
          #     startupNotify = true;
          #   };
        };
        desktop = {
        };
      };
    in
    commonDesktopEntries // (hostEntries.${hostName} or { });
}
