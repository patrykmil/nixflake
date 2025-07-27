{ user, ... }:
{
  services.xserver.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.displayManager.autoLogin = {
    enable = false;
    user = user;
  };
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  programs.dconf.profiles.gdm.databases = [
    {
      settings."org/gnome/desktop/peripherals/keyboard" = {
        numlock-state = true;
      };
    }
  ];
}
