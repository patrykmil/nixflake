{ hostName, ... }:
{
  imports =
    let
      common = [
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
        ./brave-policies.nix
      ];

      hostSpecific = {
        desktop = [
          ./nvidia.nix
          ./coolercontrol.nix
          # ./docker.nix
          ./games.nix
          ./waydroid.nix
        ];
        laptop = [
          ./bluetooth.nix
        ];
      };
    in
    common ++ (hostSpecific.${hostName} or [ ]);
}
