{ pkgs-unstable, hostName, lib, ... }:
{
  boot = lib.mkMerge [
    { kernelPackages = pkgs-unstable.linuxPackages_7_3; }
    (lib.mkIf (hostName == "dt0") {
      extraModulePackages = [ pkgs-unstable.linuxKernel.packages.linux_7_3.it87 ];
      kernelModules = [ "it87" ];
      extraModprobeConfig = ''
        options it87 ignore_resource_conflict=1 force_id=0x8686
      '';
    })
  ];
}
