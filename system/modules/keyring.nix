{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    seahorse
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
