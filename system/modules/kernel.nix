{ pkgs, hostName, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_6_18;
}