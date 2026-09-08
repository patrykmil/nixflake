{ pkgs, user, ... }:
{
  programs.fish.enable = true;
  users.users.${user} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      # "docker"
      "kvm"
      "adbusers"
      "libvirtd"
    ];
  };
}
