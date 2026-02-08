{ hostName, ... }:
{
  imports =
    let
      common = [
        ./hyprland/hyprland.nix
        ./hypridle.nix
        ./hyprpaper.nix
        # ./dank-material-shell.nix
        ./notifications.nix

        ./wezterm.nix
        ./shell.nix
        ./helix.nix
        ./git.nix
        ./jj.nix

        ./bar/waybar/waybar.nix
        # ./bar/hyprpanel/hyprpanel.nix

        ./scripts/script-modules.nix

        # ./launcher/rofi.nix
        # ./launcher/wofi.nix
        # ./launcher/wofi-power-menu.nix
        ./vicinae.nix

        # ./gammastep.nix

        ./stylix.nix

        ./webapps.nix
        ./mime.nix
      ];

      hostSpecific = {
        desktop = [
          # ./helium.nix
        ];
        laptop = [ ];
      };
    in
    common ++ (hostSpecific.${hostName} or [ ]);
}
