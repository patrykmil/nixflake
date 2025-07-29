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
  ];

  system.stateVersion = homeStateVersion;

}
