{ user, inputs, ... }:
{
  disabledModules = [ "services/display-managers/gdm.nix" ];

  imports = [
    "${inputs.nixpkgs-gdm-fix}/nixos/modules/services/display-managers/gdm.nix"
  ];

  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
  };

  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = user;
  # };
  
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/desktop/peripherals/keyboard" = {
        numlock-state = true;
      };
    }
  ];
}
