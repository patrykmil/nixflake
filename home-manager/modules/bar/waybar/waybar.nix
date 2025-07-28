{ pkgs, ... }:
let
  layout = import ./waybar-layout.nix;
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
    style = builtins.readFile ./style.css;
    settings = [
      (
        {
          output = "DP-2";
        }
        // commonSettings
        // layout.main
      )
      (
        {
          output = "!DP-2";
        }
        // commonSettings
        // layout.other
      )
    ];
  };
}
