{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      distro-grub-themes,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      user = "ptrk";
      homeStateVersion = "25.05";

      mkNixosConfig =
        host: configPath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit homeStateVersion user; };
          modules = [
            configPath
            distro-grub-themes.nixosModules.${system}.default
          ];
        };

      mkHomeConfig =
        host: homeModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs homeStateVersion user;
            hostName = host;
          };
          modules = [
            stylix.homeModules.stylix
          ] ++ homeModules;
        };
    in
    {
      nixosConfigurations.laptop = mkNixosConfig "laptop" ./system/hosts/laptop/configuration.nix;
      nixosConfigurations.desktop = mkNixosConfig "desktop" ./system/hosts/desktop/configuration.nix;

      homeConfigurations."${user}-laptop" = mkHomeConfig "laptop" [ ./home-manager/home.nix ];
      homeConfigurations."${user}-desktop" = mkHomeConfig "desktop" [ ./home-manager/home.nix ];
    };
}
