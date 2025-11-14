{
  programs.coolercontrol = {
    enable = true;
  };

  # boot.kernelModules = [
  #   "it87"
  #   "nct6687" # try Nuvoton variants
  #   "w83793"
  # ];

  # boot.extraModulePackages = lib.optional (
  #   lib.hasAttr "linuxKernel" pkgs
  #   && lib.hasAttr "packages" pkgs.linuxKernel
  #   && lib.hasAttr "linux_latest_libre" pkgs.linuxKernel.packages
  #   && lib.hasAttr "it87" pkgs.linuxKernel.packages.linux_latest_libre
  # ) pkgs.linuxKernel.packages.linux_latest_libre.it87;
}
