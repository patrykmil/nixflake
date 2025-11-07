{
  config,
  pkgs,
  lib,
  inputs,
  system,
  hostName,
  ...
}:
{
  imports = [
    inputs.distro-grub-themes.nixosModules.${system}.default
  ];

  boot.loader = {
    timeout = 30;
    grub = {
      enable = true;
      efiSupport = if hostName == "desktop" then false else true;
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
