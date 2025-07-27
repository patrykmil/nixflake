{
  config,
  pkgs,
  user,
  homeStateVersion,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../system-packages.nix
    ../../modules
    ../../modules/nvidia.nix
  ];

  system.stateVersion = homeStateVersion;

}
