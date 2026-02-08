{ homeStateVersion, user, ... }:
{
  imports = [
    ./home-packages.nix
    ./home-modules.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
