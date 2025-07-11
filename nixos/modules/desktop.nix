{ user, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = user;
  };
  services.desktopManager.plasma6.enable = false;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
}
