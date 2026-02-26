{ pkgs, ... }:
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    heroic
    mangohud
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.config/heroic/tools/proton";
  };
}
