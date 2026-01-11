let
  modules = import ./waybar-modules.nix;
in
{
  main-desktop = {
    modules-left = [
      "custom/apps"
      "custom/divider"
      "hyprland/workspaces"
    ];
    modules-center = [
      "hyprland/window"
    ];
    modules-right = [
      # "custom/monitor-toggle"
      "group/tray"
      "network"
      "custom/divider"
      "pulseaudio"
      "pulseaudio#microphone"
      "custom/divider"
      "custom/clock2"
    ];
  } // modules;

  main-laptop = {
    modules-left = [
      "custom/apps"
      "custom/divider"
      "hyprland/workspaces"
    ];
    modules-center = [
      # "hyprland/window"
    ];
    modules-right = [
      "group/tray"
      "network"
      "custom/divider"
      "pulseaudio"
      "pulseaudio#microphone"
      "custom/divider"
      "battery"
      "backlight"
      "custom/divider"
      "custom/clock2"
    ];
  } // modules;

  other = {
    modules-left = [ ];
    modules-center = [ "hyprland/window" ];
    modules-right = [ "hyprland/workspaces" ];
  } // modules;
}
