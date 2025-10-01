{ pkgs, hostName, ... }:
{
  programs.hyprland.enable = true;
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  }
  // (
    if hostName == "laptop" then
      {
        NIXOS_OZONE_WL = "1";
      }
    else
      { }
  );

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-utils
  ];
}
