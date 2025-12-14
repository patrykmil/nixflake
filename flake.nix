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
          modules = [ configPath ];
        };

      mkHomeConfig =
        host: homeModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${hostSystem};
          extraSpecialArgs = {
            inherit inputs homeStateVersion user;
            hostName = host;
            system = hostSystem;
          };
          modules = [ ] ++ homeModules;
        };
    in

    {
      nixosConfigurations.laptop = mkNixosConfig "laptop" ./system/hosts/laptop/configuration.nix;
      nixosConfigurations.desktop = mkNixosConfig "desktop" ./system/hosts/desktop/configuration.nix;

      homeConfigurations."${user}-laptop" = mkHomeConfig "laptop" [ ./home-manager/home.nix ];
      homeConfigurations."${user}-desktop" = mkHomeConfig "desktop" [ ./home-manager/home.nix ];
    };
}
