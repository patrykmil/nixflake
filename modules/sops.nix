{
  pkgs,
  config,
  lib,
  ...
}: {
  # sops-nix options come from sops-nix.nixosModules.sops (already imported in
  # flake.nix for every host). This module gives each host a stable decrypt
  # identity and the `sops` CLI.

  # Identity: use a dedicated age key generated on first boot at
  # /home/ptrk/.config/sops/age/keys.txt (persists across rebuilds).
  sops.age.keyFile = "/home/ptrk/.config/sops/age/keys.txt";
  sops.age.generateKey = true;
  sops.age.sshKeyPaths = [ ];

  # Encrypted secrets live at secrets/secrets.yaml in the repo root.
  # To create it, from a machine that holds the age key:
  #   mkdir -p secrets
  #   sops secrets/secrets.yaml
  # sops.defaultSopsFile = ../secrets/secrets.yaml;
  # sops.secrets.example = { };

  environment.systemPackages = [ pkgs.sops ];
}