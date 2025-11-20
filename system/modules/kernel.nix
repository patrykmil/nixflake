{ pkgs, hostName, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_6_17;

  boot.extraModulePackages = if hostName == "desktop" then [ pkgs.linuxKernel.packages.linux_6_17.it87 ] else [];
  boot.kernelModules = if hostName == "desktop" then [ "it87" ] else [];
  boot.extraModprobeConfig = if hostName == "desktop" then ''
    options it87 ignore_resource_conflict=1 force_id=0x8686
  '' else "";
}