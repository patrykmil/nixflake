{ ... }:
{
  xdg.portal = {
    enable = true;

    # The gtk backend comes from programs.hyprland / programs.umbriel
    # (wayland-session.nix), which add it to extraPortals.

    # xdg-desktop-portal reads <desktop>-portals.conf first, then portals.conf.
    # Keep umbriel first in the fallback so the running compositor's backend
    # wins when XDG_CURRENT_DESKTOP is not published by the session.
    config = {
      common.default = [ "umbriel" "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
      umbriel.default = [ "umbriel" "gtk" ];
    };
  };
}
