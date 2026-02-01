{ pkgs, ... }:
{
  programs.coolercontrol = {
    enable = true;
  };

  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_18.it87 ];
  boot.kernelModules = [ "it87" ];
  boot.extraModprobeConfig = ''
    options it87 ignore_resource_conflict=1 force_id=0x8686
  '';
}
