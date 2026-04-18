{ hostName, ... }:
{
  imports =
    let
      mod = path: ./modules + ("/" + path);

      common = map mod [
        "hyprland/hyprland.nix"
        "hypridle.nix"
        "hyprpaper.nix"
        "vicinae/vicinae.nix"
        "waybar/waybar.nix"
        "notifications.nix"

        "wezterm.nix"
        "shell.nix"
        "helix.nix"
        "git.nix"
        "jj.nix"
        "opencode/opencode.nix"

        "scripts/script-modules.nix"
        "webapps.nix"
        "stylix.nix"
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
