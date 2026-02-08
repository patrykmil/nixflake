{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi-power-menu
  ];

  home.file.".config/wofi-power-menu.toml".text = ''
    [menu.suspend]
    cmd = "systemctl suspend"
    requires_confirmation = "false"

    [menu.shutdown]
    cmd = "systemctl poweroff"
    requires_confirmation = "false"

    [menu.reboot]
    cmd = "systemctl reboot"
    requires_confirmation = "false"

    [menu.logout]
    cmd = "hyprctl dispatch exit"

    [menu.lock-screen]
    cmd = "hyprlock"
    enabled = "false"

    [menu.hibernate]
    enabled = "false"
  '';
}
