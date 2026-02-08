{
  config,
  pkgs,
  hostMonitors,
  hostName,
  ...
}:
let
  layout = import ./waybar-layout.nix { inherit config hostMonitors; };
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
          output = hostMonitors.primary;
        }
        // commonSettings
        // layout.main-desktop
      )
      (
        {
          output = hostMonitors.laptop;
        }
        // commonSettings
        // layout.main-laptop
      )
      (
        {
          output = hostMonitors.secondary;
        }
        // commonSettings
        // layout.other
      )
    ];
  };
}
