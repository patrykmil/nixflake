{ hostClass, ... }:
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
        "atk.nix"
        "media.nix"
        "portal.nix"
        "noctalia/noctalia-system.nix"
        "hyprland/hyprland.nix"
        "keyring.nix"
        # "polkit.nix"
        "printing.nix"
        "kernel.nix"
        "files.nix"
        "localsend.nix"
        "vms.nix"
        "docker.nix"
        # "dns.nix"
        # "sops.nix"
        "tailscale.nix"
      ];

      hostSpecific = {
        desktop = map mod [
          "intel-gpu.nix"
          "coolercontrol.nix"
          "games.nix"
          "umbriel/umbriel.nix"
          # "waydroid.nix"
        ];
        laptop = map mod [
          "bluetooth.nix"
          "battery.nix"
          "vmware.nix"
        ];
      };
    in
    common ++ (hostSpecific.${hostClass} or [ ]);
}
