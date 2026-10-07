{ inputs, pkgs-unstable, ... }:
{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/umbriel.nix"
  ];

  # Side-by-side with Hyprland: session + portal wired by the module, default
  # session stays Hyprland (see login.nix). Packages pinned to pkgs-unstable
  # per repo convention; the module defaults would use stable.
  programs.umbriel = {
    enable = true;
    package = pkgs-unstable.umbriel;
    portalPackage = pkgs-unstable.xdg-desktop-portal-umbriel;
  };
}
