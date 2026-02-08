{ pkgs, ... }:
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    heroic
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.config/heroic/tools/proton";
  };
}