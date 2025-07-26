{
  "hyprland/window" = {
    format = "{}";
    tooltip = false;
  };

  network = {
    format = "󰖩 {essid}";
    format-ethernet = "󱎔 Wired";
    format-disconnected = "󰖪 Dced";
    on-click = "alacritty -e nmtui";
  };

  clock = {
    format = "{:%H:%M -- %m/%d} ";
    tooltip-format = ''
      <big>{:%Y %B}</big>
      <tt><small>{calendar}</small></tt>'';
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    tooltip = true;
    format-muted = "󰖁 Muted";
    on-click = "pavucontrol";
    on-click-right = "pamixer -t";
    on-scroll-up = "pamixer -i 5";
    on-scroll-down = "pamixer -d 5";
    scroll-step = 5;
    format-icons = {
      default = [
        ""
        ""
        ""
      ];
    };
  };

  "pulseaudio#microphone" = {
    format = "{format_source}";
    tooltip = true;
    format-source = "󰍬 {volume}%";
    format-source-muted = "󰍭 Muted";
    on-click = "pavucontrol-dark";
    on-click-right = "pamixer --default-source -t";
    on-scroll-up = "pamixer --default-source -i 5";
    on-scroll-down = "pamixer --default-source -d 5";
    scroll-step = 5;
  };

  "custom/apps" = {
    "format" = "  Apps";
    "on-click" = "wofi --show drun -replace";
    "on-click-right" = "wofi-power-menu";
    tooltip = false;
  };

  "custom/divider" = {
    format = " | ";
    interval = "once";
    tooltip = false;
  };

  "hyprland/workspaces" = {
    move-to-monitor = true;
    all-outputs = true;
  };

  "custom/monitor-toggle" = {
    format = "{}";
    tooltip = false;
    exec = "bash -c 'hyprctl monitors | grep -q HDMI-A-1 && echo \"󰍺\" || echo \"󰍹\"'";
    interval = 5;
    on-click = "~/.config/scripts/toggle-second-monitor.sh";
  };
}
