{ pkgs, inputs, ... }:
{
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  environment.systemPackages = with pkgs; [
    lzip
    inputs.waydroid-script.packages.${pkgs.system}.default
  ];
}
