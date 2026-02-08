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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
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

      monitors = import ./vars/monitors.nix;
      fonts = import ./vars/fonts.nix;

      mkNixosConfig =
        host: configPath:
        nixpkgs.lib.nixosSystem {
          system = hostSystem;
          specialArgs = {
            inherit
              inputs
              homeStateVersion
              user
              monitors
              fonts
              ;
            system = hostSystem;
            hostName = host;
            hostMonitors = monitors.${host};
          };
          modules = [
            configPath
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  homeStateVersion
                  user
                  monitors
                  fonts
                  ;
                hostName = host;
                system = hostSystem;
                hostMonitors = monitors.${host};
              };
              home-manager.backupFileExtension = "backup";
              home-manager.users.${user} = import ./home.nix;
            }
          ];
        };
    in

    {
      nixosConfigurations = nixpkgs.lib.genAttrs [ "laptop" "desktop" ] (
        host: mkNixosConfig host ./configuration.nix
      );
    };
}
