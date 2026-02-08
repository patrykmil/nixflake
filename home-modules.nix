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

        "bar/waybar/waybar.nix"
        # "bar/hyprpanel/hyprpanel.nix"

        "scripts/script-modules.nix"

        # "launcher/rofi.nix"
        # "launcher/wofi.nix"
        # "launcher/wofi-power-menu.nix"
        "vicinae.nix"

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
