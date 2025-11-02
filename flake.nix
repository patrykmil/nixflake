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

    # dgop = {
    #   url = "github:AvengeMedia/dgop";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # dms-cli = {
    #   url = "github:AvengeMedia/danklinux";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # dankMaterialShell = {
    #   url = "github:AvengeMedia/DankMaterialShell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.dgop.follows = "dgop";
    #   inputs.dms-cli.follows = "dms-cli";
    # };

    vicinae = {
      url = "github:vicinaehq/vicinae";
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
      system = "x86_64-linux";
      user = "ptrk";
      homeStateVersion = "25.11";

      mkNixosConfig =
        host: configPath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              homeStateVersion
              user
              system
              ;
            hostName = host;
          };
          modules = [ configPath ];
        };

      mkHomeConfig =
        host: homeModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs homeStateVersion user;
            hostName = host;
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
