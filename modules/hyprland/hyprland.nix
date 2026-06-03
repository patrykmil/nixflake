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
    settings.xwayland.force_zero_scaling = true;
    configType = "hyprlang";
  };
}
