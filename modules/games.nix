{ pkgs, user, ... }:
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    heroic
    mangohud
    appimage-run
    (writeShellScriptBin "epic-games-launcher" ''
      exec ${appimage-run}/bin/appimage-run /home/${user}/Apps/EpicGamesLauncher-x86_64.AppImage "$@"
    '')
    (makeDesktopItem {
      name = "epic-games-launcher";
      desktopName = "Epic Games Launcher";
      exec = "epic-games-launcher %U";
      icon = "epic-games-launcher";
      type = "Application";
      categories = [ "Game" ];
    })
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.config/heroic/tools/proton";
  };
}
