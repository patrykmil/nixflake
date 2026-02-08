{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    xarchiver
    nemo
    nemo-fileroller
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
