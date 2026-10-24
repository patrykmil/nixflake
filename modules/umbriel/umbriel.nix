{ inputs, pkgs-unstable, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/umbriel.nix"
  ];

  programs.umbriel = {
    enable = true;
    package = pkgs-unstable.umbriel;
    portalPackage = pkgs-unstable.xdg-desktop-portal-umbriel;
  };
}
