{
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
      default = "saved";
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
