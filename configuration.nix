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
    ./hosts/${hostName}-hardware.nix
    ./system-packages.nix
    ./system-modules.nix
  ];

  system.stateVersion = homeStateVersion;
}
