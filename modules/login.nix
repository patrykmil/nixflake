{ user, inputs, pkgs, ... }:
{

  services.xserver.enable = true;

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
    greeter-args = "--session hyprland";
    settings = {
      keyboard = {
        layout = "pl";
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
}
