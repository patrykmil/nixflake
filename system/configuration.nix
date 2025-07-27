{
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./system-packages.nix
    ./modules
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.command-not-found.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "25.05";
}
