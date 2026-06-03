{
  description = "Skibidi";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-gdm-fix.url = "github:nixos/nixpkgs/7fdb15681cb5daa386e25abe7ce611d2744ecc83";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    waydroid-script = {
      url = "github:casualsnek/waydroid_script";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:

    let
      hostSystem = "x86_64-linux";
      user = "ptrk";
      homeStateVersion = "25.11";

      monitors = import ./vars/monitors.nix;
      fonts = import ./vars/fonts.nix;

      pkgs-unstable = import nixpkgs-unstable {
        system = hostSystem;
        config.allowUnfree = true;
      };

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
              pkgs-unstable
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
                  pkgs-unstable
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
