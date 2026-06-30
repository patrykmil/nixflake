{
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
let
  windowsEntry = {
    desktop = ''
      /Windows
        protocol: efi
        path: uuid(f91e2a5c-d2dc-434e-8445-88d5fdc49a8f):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
in
{
  boot.loader = {
    timeout = 30;
    limine = {
      enable = true;
      efiSupport = true;
      style = {
        wallpapers = [ ];
        backdrop = "000000";
      };
      extraEntries = windowsEntry.${hostName} or "";
      secureBoot = lib.mkIf (hostName == "desktop") {
        enable = true;
        autoGenerateKeys = true;
        autoEnrollKeys = {
          enable = true;
          extraArgs = [
            "--microsoft"
            "--firmware-builtin"
          ];
        };
      };
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
