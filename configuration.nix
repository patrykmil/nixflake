{
  config,
  pkgs,
  user,
  homeStateVersion,
  hostName,
  ...
}:

{
  imports = [
    ./hosts/${hostName}/hardware-configuration.nix
    ./system-packages.nix
    ./system-modules.nix
  ];

  system.stateVersion = homeStateVersion;
}
