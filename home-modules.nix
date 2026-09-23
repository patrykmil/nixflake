{ hostClass, ... }:
{
  imports =
    let
      mod = path: ./modules + ("/" + path);

      common = map mod [
        "hyprland/hyprland-hm.nix"
        # "hypridle.nix"
        # "hyprpaper.nix"
        "vicinae/vicinae.nix"
        # "waybar/waybar.nix"
        # "notifications.nix"
        "noctalia/noctalia.nix"

        "wezterm.nix"
        "shell.nix"
        "helix.nix"
        "git.nix"
        # "jj.nix"
        "opencode/opencode.nix"
        "vscode/vscode.nix"

        "scripts/script-modules.nix"
        "webapps.nix"
        "stylix.nix"
        "mime.nix"
      ];

      hostSpecific = {
        desktop = map mod [
          # "hermes.nix"
        ];
        laptop = map mod [ ];
      };
    in
    common ++ (hostSpecific.${hostClass} or [ ]);
}
