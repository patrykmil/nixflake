{
  description = "Skibidi";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # waydroid-script = {
    #   url = "github:casualsnek/waydroid_script";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    gloview = {
      url = "github:fedsfarm/gloview";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-master,
      home-manager,
      # sops-nix,
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

      pkgs-master = import nixpkgs-master {
        system = hostSystem;
        config.allowUnfree = true;
      };

      mkNixosConfig =
        host: configPath:
        let
          commonArgs = {
            inherit
              inputs
              homeStateVersion
              user
              monitors
              fonts
              pkgs-unstable
              pkgs-master
              ;
            system = hostSystem;
            hostName = host;
            hostMonitors = monitors.${host};
          };
        in
        nixpkgs.lib.nixosSystem {
          system = hostSystem;
          specialArgs = commonArgs;
          modules = [
            configPath
            home-manager.nixosModules.home-manager
            # sops-nix.nixosModules.sops
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = commonArgs;
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
