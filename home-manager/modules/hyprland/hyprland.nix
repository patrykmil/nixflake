{
  config,
  pkgs,
  hostName,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
      hyprscrolling
    ];

    settings =
      (import ./monitors.nix { inherit hostName; })
      // (import ./inputs.nix)
      // (import ./look.nix)
      // (import ./layouts.nix)
      // (import ./binds.nix)
      // (import ./window-rules.nix)
      // (import ./autostart.nix { inherit pkgs; })
      // (import ./plugins.nix);

    extraConfig = (import ./sensitivity.nix).extraConfig;
  };
}
