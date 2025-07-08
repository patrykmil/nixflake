{
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.command-not-found.enable = false;

  system.stateVersion = "25.05";
}
