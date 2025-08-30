{ hostName, ... }:
{
  imports =
    [
      ./boot.nix
      ./user.nix
      ./gc.nix
      ./networking.nix
      ./locale.nix
      ./login.nix
      ./audio.nix
      ./firewall.nix
      ./hyprland.nix
      ./keyring.nix
      ./printing.nix
      ./experimental.nix
      ./kernel.nix
      ./usb.nix
    ]
    ++ (
      if hostName == "desktop" then
        [
          ./nvidia.nix
        ]
      else if hostName == "laptop" then
        [

        ]
      else
        [

        ]
    );
}
