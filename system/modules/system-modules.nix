{ hostName, ... }:
{
  imports = [
    ./cachix.nix
    ./bootloader.nix
    ./user.nix
    ./gc.nix
    ./networking.nix
    ./locale.nix
    ./login.nix
    ./media.nix
    ./firewall.nix
    ./hyprland.nix
    ./keyring.nix
    ./polkit.nix
    ./printing.nix
    ./experimental.nix
    ./kernel.nix
    ./files.nix
    # ./platformio.nix
  ]
  ++ (
    if hostName == "desktop" then
      [
        ./nvidia.nix
        ./fancontrol.nix
        ./docker.nix
        ./steam.nix
      ]
    else if hostName == "laptop" then
      [
        # ./battery.nix
        ./bluetooth.nix
      ]
    else
      [

      ]
  );
}
