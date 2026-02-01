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
    ../../system/system-packages.nix
    ../../system/modules/system-modules.nix
  ];

  system.stateVersion = homeStateVersion;

}
