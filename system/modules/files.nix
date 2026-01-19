{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    xarchiver
    nemo-with-extensions
    nemo-fileroller
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
