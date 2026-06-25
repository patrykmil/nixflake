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
        path: uuid(1545fd47-f059-4727-9266-85e9581ec2e9):/EFI/Microsoft/Boot/bootmgfw.efi
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
