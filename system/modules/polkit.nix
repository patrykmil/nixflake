{ pkgs, ... }:
{
  security.polkit = {
    enable = true;
    package = pkgs.polkit;
  };

  environment.systemPackages = with pkgs; [
    mate.mate-polkit
  ];
}
