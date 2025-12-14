{
  description = "Skibidi";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wifitui = {
      url = "github:shazow/wifitui";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:

    let
      hostSystem = "x86_64-linux";
      user = "ptrk";
      homeStateVersion = "25.11";

      mkNixosConfig =
        host: configPath:
        nixpkgs.lib.nixosSystem {
          system = hostSystem;
          specialArgs = {
            inherit
              inputs
              homeStateVersion
              user
              ;
            system = hostSystem;
            hostName = host;
          };
          modules = [
            configPath
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                inherit inputs homeStateVersion user;
                hostName = host;
                system = hostSystem;
              };
              home-manager.backupFileExtension = "backup";
              home-manager.users.${user} = import ./home-manager/home.nix;
            }
          ];
        };
    in

    {
      nixosConfigurations.laptop = mkNixosConfig "laptop" ./system/hosts/laptop/configuration.nix;
      nixosConfigurations.desktop = mkNixosConfig "desktop" ./system/hosts/desktop/configuration.nix;
    };
}
