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
      # "custom/divider"
      "network"
      "custom/divider"
      "pulseaudio"
      "pulseaudio#microphone"
      "custom/divider"
      "clock"
    ];
  } // modules;

  main-laptop = {
    modules-left = [
      "custom/apps"
      "custom/divider"
      "hyprland/workspaces"
    ];
    modules-center = [
      "hyprland/window"
    ];
    modules-right = [
      "pulseaudio"
      "pulseaudio#microphone"
      "custom/divider"
      "battery"
      "backlight"
      "custom/divider"
      "clock"
    ];
  } // modules;

  other = {
    modules-left = [ ];
    modules-center = [ "hyprland/window" ];
    modules-right = [ "hyprland/workspaces" ];
  } // modules;
}
