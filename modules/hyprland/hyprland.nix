{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
{
  imports = [
    ./monitors.nix
    ./inputs.nix
    ./look.nix
    ./layouts.nix
    ./binds.nix
    ./window-rules.nix
    ./autostart.nix
    ./plugins.nix
    ./sensitivity.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprscrolling
    ];
    settings.xwayland.force_zero_scaling = true;
  };
}
