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
    ../../modules/udev.nix
  ];

  system.stateVersion = homeStateVersion;

}
