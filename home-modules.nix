{ hostName, ... }:
{
  imports =
    let
      mod = path: ./modules + ("/" + path);

      common = map mod [
        "hyprland/hyprland.nix"
        "hypridle.nix"
        "hyprpaper.nix"
        # "dank-material-shell.nix"
        "notifications.nix"

        "wezterm.nix"
        "shell.nix"
        "helix.nix"
        "git.nix"
        "jj.nix"

        "waybar/waybar.nix"
        # "hyprpanel/hyprpanel.nix"

        "scripts/script-modules.nix"

        # "rofi.nix"
        # "wofi.nix"
        # "wofi-power-menu.nix"
        "vicinae/vicinae.nix"

        # "gammastep.nix"

        "stylix.nix"

        "webapps.nix"
        "mime.nix"
      ];

      hostSpecific = {
        desktop = map mod [
          # "helium.nix"
        ];
        laptop = map mod [ ];
      };
    in
    common ++ (hostSpecific.${hostName} or [ ]);
}
