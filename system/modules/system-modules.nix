{ hostName, ... }:
{
  imports = [
    ./settings.nix
    ./bootloader.nix
    ./user.nix
    ./gc.nix
    ./networking.nix
    ./locale.nix
    ./login.nix
    ./media.nix
    ./hyprland.nix
    ./keyring.nix
    ./polkit.nix
    ./printing.nix
    ./kernel.nix
    ./files.nix
    ./localsend.nix
    # ./platformio.nix
  ]
  ++ (
    if hostName == "desktop" then
      [
        ./nvidia.nix
        ./fancontrol.nix
        # ./docker.nix
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
