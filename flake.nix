{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      distro-grub-themes,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      user = "ptrk";
      homeStateVersion = "25.05";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit user;
        };
        modules = [
          ./nixos/configuration.nix
          distro-grub-themes.nixosModules.${system}.default
        ];
      };

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs homeStateVersion user;
        };
        modules = [ ./home-manager/home.nix ];
      };
    };
}
