{ config, pkgs, ... }:
let
  layout = import ./waybar-layout.nix { inherit config; };
  commonSettings = {
    layer = "top";
    position = "bottom";
    mod = "dock";
    exclusive = true;
    passthrough = false;
    gtk-layer-shell = true;
    height = 0;
  };
in
{
  programs.waybar = {
    enable = true;
    settings = [
      (
        {
          output = "DP-2";
        }
        // commonSettings
        // layout.main-desktop
      )
      (
        {
          output = "eDP-1";
        }
        // commonSettings
        // layout.main-laptop
      )
      (
        {
          output = "HDMI-A-1";
        }
        // commonSettings
        // layout.other
      )
    ];
  };
}
