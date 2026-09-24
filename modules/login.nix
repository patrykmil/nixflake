{ inputs, pkgs-unstable, lib, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/display-managers/noctalia-greeter.nix"
  ];

  # ponytail: shim, stable 26.05 always installs the pkexec wrapper which is
  # what upstream defaults to; drop once base nixpkgs knows this option.
  options.security.polkit.enablePkexecWrapper = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = {
    services.xserver.enable = true;

    services.displayManager.noctalia-greeter = {
      enable = true;
      package = pkgs-unstable.noctalia-greeter;
      extraArgs = [
        "--session"
        "hyprland"
      ];
      settings = {
        keyboard = {
          layout = "pl";
          numlock = true;
        };
      };
    };

    services.displayManager.defaultSession = "hyprland";

    services.xserver.xkb = {
      layout = "pl";
      variant = "";
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*::numlock", ATTR{brightness}="1"
    '';
  };
}
