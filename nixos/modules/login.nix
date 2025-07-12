{ user, ... }:
{
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = user;
  };
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
}
