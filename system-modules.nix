{ hostName, ... }:
{
  imports =
    let
      mod = path: ./modules + ("/" + path);

      common = map mod [
        "settings.nix"
        "bootloader.nix"
        "user.nix"
        "gc.nix"
        "networking.nix"
        "locale.nix"
        "login.nix"
        "media.nix"
        "hyprland.nix"
        "keyring.nix"
        "polkit.nix"
        "printing.nix"
        "kernel.nix"
        "files.nix"
        "localsend.nix"
        "brave-policies.nix"
      ];

      hostSpecific = {
        desktop = map mod [
          "nvidia.nix"
          "coolercontrol.nix"
          # "docker.nix"
          "games.nix"
          "waydroid.nix"
        ];
        laptop = map mod [
          "bluetooth.nix"
        ];
      };
    in
    common ++ (hostSpecific.${hostName} or [ ]);
}
