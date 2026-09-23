{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  hostClass,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  imports = [
    ./plugins.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    settings.xwayland.force_zero_scaling = true;
    configType = "hyprlang";
  };

  xdg.configFile."hypr/hyprland-common.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/hyprland/hyprland-common.lua";

  xdg.configFile."hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/hyprland/hyprland-${hostClass}.lua";
}
