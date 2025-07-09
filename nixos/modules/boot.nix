{
  config,
  pkgs,
  lib,
  ...
}:
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

  distro-grub-themes = {
    enable = true;
    theme = "nixos";
  };
}
