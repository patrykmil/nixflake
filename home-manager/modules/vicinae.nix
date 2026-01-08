{ pkgs, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      favicon_service = "twenty";
      search_files_in_root = false;
      pop_to_root_on_close = true;
      font = {
        normal = {
          size = 11;
          normal = "Maple Mono NF";
        };
      };
      theme.name = "rose-pine";
      theme = {
        light = {
          name = "rose-pine";
          icon_theme = "Adwaita";
        };
        dark = {
          name = "rose-pine";
          icon_theme = "Adwaita";
        };
      };
      launcher_window = {
        opacity = 1;
      };
      providers = {
        "clipboard" = {
          "entrypoints" = {
            "history" = {
              "preferences" = {
                "defaultAction" = "copy";
              };
            };
          };
        };
        "core" = {
          "entrypoints" = {
            "about" = {
              "enabled" = false;
            };
            "documentation" = {
              "enabled" = false;
            };
            "keybind-settings" = {
              "enabled" = false;
            };
            "manage-fallback" = {
              "enabled" = false;
            };
            "oauth-token-store" = {
              "enabled" = false;
            };
            "open-default-config" = {
              "enabled" = false;
            };
            "reload-scripts" = {
              "enabled" = false;
            };
            "report-bug" = {
              "enabled" = false;
            };
            "settings" = {
              "enabled" = false;
            };
            "sponsor" = {
              "enabled" = false;
            };
          };
        };
        "developer" = {
          "enabled" = false;
        };
        "font" = {
          "enabled" = false;
        };
        "power" = {
          "entrypoints" = {
            "hibernate" = {
              "enabled" = false;
            };
            "lock" = {
              "enabled" = false;
            };
            "power-off" = {
              "alias" = "Shutdown";
              "preferences" = {
                "confirm" = false;
              };
            };
            "reboot" = {
              "preferences" = {
                "confirm" = false;
              };
            };
            "sleep" = {
              "enabled" = false;
            };
            "soft-reboot" = {
              "enabled" = false;
            };
            "suspend" = {
              "preferences" = {
                "confirm" = false;
              };
            };
          };
        };
        "theme" = {
          "enabled" = false;
        };
      };
    };
  };
}
