{ homeStateVersion, user, ... }:
{
  imports = [
    ./home-packages.nix
    ./modules/home-modules.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
