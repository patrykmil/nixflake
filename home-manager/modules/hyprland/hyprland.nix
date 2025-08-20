{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings =
      (import ./monitors.nix)
      // (import ./inputs.nix)
      // (import ./look.nix)
      // (import ./layouts.nix)
      // (import ./binds.nix)
      // (import ./window-rules.nix)
      // (import ./autostart.nix { inherit pkgs; });

    extraConfig = (import ./sensitivity.nix).extraConfig;
  };
}
