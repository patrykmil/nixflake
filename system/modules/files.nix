{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };  
}
