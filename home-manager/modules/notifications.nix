{ pkgs, ... }:
{
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
    settings = {
      positionX = "right";
      positionY = "bottom";
      control-center-margin-top = 50;
      control-center-margin-bottom = 50;
      control-center-margin-right = 50;
      control-center-margin-left = 50;
    };
  };
}
