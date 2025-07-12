{ user, ... }:
{
  services.xserver.enable = true;

  program.hyprlock.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = user;
  };
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };
}
