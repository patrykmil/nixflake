
{ pkgs, pkgs-unstable, hostClass, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    xwayland.enable = true;
    portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  }
  // (
    if hostClass == "laptop" then
      {
        ELECTRON_ENABLE_WAYLAND = "1";
        # GDK_BACKEND = "wayland";
        QT_QPA_PLATFORM = "wayland";
        NIXOS_OZONE_WL = "1";
      }
    else
      { }
  );
}

# tr '\0' '\n' < /proc/3395/environ | egrep 'WAYLAND_DISPLAY|DISPLAY|ELECTRON_ENABLE_WAYLAND|GDK_BACKEND|QT_QPA_PLATFORM'