{ user, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin = {
    enable = false;
    user = user;
  };
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
}
