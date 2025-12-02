{
  "hyprland/window" = {
    format = "{}";
    tooltip = false;
    max-length = 50;
  };

  network = {
    format = "󰖩 Wifi";
    format-ethernet = "󱎔 Wired";
    format-disconnected = "󰖪 Dced";
    on-click = "pkill wifitui || alacritty --class wifitui -e wifitui";
  };

  clock = {
    format = "{:%H:%M -- %d/%m} ";
    tooltip-format = ''
      <big>{:%Y %B}</big>
      <tt><small>{calendar}</small></tt>'';
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    tooltip = true;
    format-muted = "󰖁 Muted";
    on-click = "pkill pavucontrol || pavucontrol";
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
    on-click = "pkill pavucontrol || pavucontrol";
    on-click-right = "pamixer --default-source -t";
    on-scroll-up = "pamixer --default-source -i 5";
    on-scroll-down = "pamixer --default-source -d 5";
    scroll-step = 5;
  };

  "custom/apps" = {
    "format" = "  ";
    "on-click" = "vicinae toggle";
    "on-click-right" = "alacritty";
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

  battery = {
    interval = 60;
    format = "{icon} {capacity}%";
    format-charging = "󱐋 {capacity}%";
    format-icons = [
      "󱊡"
      "󱊢"
      "󱊣"
    ];
    tooltip = true;
    tooltip-format = ''{time}'';
    max-length = 25;
  };

  backlight = {
    device = "intel_backlight";
    format = " {percent}%";
    interval = 5;
    tooltip = false;
    on-scroll-down = "brightnessctl set 5%-";
    on-scroll-up = "brightnessctl set +5%";
  };
}