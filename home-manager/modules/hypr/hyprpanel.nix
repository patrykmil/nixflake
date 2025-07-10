{
  programs.hyprpanel.enable = true;

  programs.hyprpanel.settings = {
    bar = {
      customModules = {
        storage = {
          paths = [ "/" ];
        };
      };
      layouts = {
        "DP-2" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
          ];
          right = [
            "volume"
            "network"
            "systray"
            "clock"
            "notifications"
          ];
        };
        "HDMI-A-1" = {
          middle = [
            "workspaces"
            "windowtitle"
          ];
        };
      };
      location = "bottom";
      buttons = {
        enableBorders = false;
        dashboard = {
          enableBorder = true;
        };
        workspaces = {
          enableBorder = false;
        };
        volume = {
          enableBorder = false;
        };
        network = {
          enableBorder = false;
        };
        systray = {
          enableBorder = false;
        };
        clock = {
          enableBorder = false;
          spacing = "0.3em";
        };
      };
      border = {
        location = "top";
        width = "0.05em";
      };
      outer_spacing = "1.5em";
      launcher = {
        icon = "󱄅";
        autoDetectIcon = false;
      };
      workspaces = {
        show_icons = false;
        show_numbered = false;
        monitorSpecific = true;
        workspaceMask = false;
        showWsIcons = true;
        showApplicationIcons = true;
        numbered_active_indicator = "underline";
      };
      network = {
        showWifiInfo = true;
      };
      clock = {
        format = "%a %d %b %H:%M";
        showIcon = false;
        showTime = true;
      };
      media = {
        show_label = true;
        truncation = true;
        truncation_size = 30;
      };
      notifications = {
        show_total = true;
        hideCountWhenZero = true;
      };
    };
    theme = {
      bar = {
        floating = false;
        menus = {
          monochrome = false;
        };
        location = "bottom";
        buttons = {
          enableBorders = false;
          dashboard = {
            enableBorder = true;
          };
          workspaces = {
            enableBorder = false;
          };
          volume = {
            enableBorder = false;
          };
          network = {
            enableBorder = false;
          };
          systray = {
            enableBorder = false;
          };
          clock = {
            enableBorder = false;
            spacing = "0.3em";
          };
        };
        border = {
          location = "top";
          width = "0.05em";
        };
        outer_spacing = "1.5em";
        menus = {
          menu = {
            power = {
              scaling = 90;
            };
            dashboard = {
              profile = {
                size = "8.5em";
              };
            };
          };
        };
      };
      font = {
        name = "MesloLGS NF";
        label = "MesloLGS NF";
        size = "1.1rem";
        weight = 500;
      };
    };
    wallpaper = {
      pywal = false;
    };
    menus = {
      clock = {
        weather = {
          location = "Kraków";
          unit = "metric";
        };
        time = {
          military = true;
        };
      };
      dashboard = {
        shortcuts = {
          enabled = false;
        };
        controls = {
          enabled = true;
        };
        stats = {
          enabled = false;
        };
        powermenu = {
          confirmation = true;
          avatar.image = "/home/ptrk/flakes/home-manager/modules/hypr/nix.png";
        };
      };
      transition = "crossfade";
    };
    scalingPriority = "hyprland";
  };
}
