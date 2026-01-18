{
  "hyprland/window" = {
    format = "{}";
    tooltip = false;
    max-length = 50;
  };

  network = {
    format = "󰖩";
    format-ethernet = "󱎔";
    format-disconnected = "󰖪";
    on-click = "pkill wifitui || alacritty --class wifitui -e wifitui";
  };

  "custom/clock2" = {
    interval = 60;
    return-type = "json";
    exec = "python3 /home/ptrk/flakes/home-manager/modules/bar/waybar/cal.py";
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    tooltip = true;
    format-muted = "󰖁";
    on-click = "pkill pwvucontrol || pwvucontrol";
    on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
    on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
    scroll-step = 5;
    format-icons = {
      default = [
        ""
        ""
      ];
    };
  };

  "pulseaudio#microphone" = {
    format = "{format_source}";
    tooltip = true;
    format-source = "󰍬 {volume}%";
    format-source-muted = "󰍭";
    on-click = "pkill pwvucontrol || pwvucontrol";
    on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
    on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
    scroll-step = 5;
  };

  "custom/apps" = {
    "format" = "  ";
    "on-click" = "vicinae toggle";
    "on-click-right" = "swaync-client -t";
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

  tray = {
    icon-size = 16;
    spacing = 5;
  };

  "custom/tray" = {
    exec = "/home/ptrk/flakes/home-manager/modules/bar/waybar/tray.sh";
    interval = 5;
    format = "{}";
  };

  "group/tray" = {
    orientation = "horizontal";
    "drawer" = {
      "transition-duration" = 250;
      "transition-left-to-right" = false;
    };
    modules = [
      "custom/tray"
      "tray"
    ];
  };
}
