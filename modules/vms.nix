{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dnsmasq
    virtiofsd
  ];

  virtualisation.libvirtd.enable = true;
  
  programs.virt-manager.enable = true;
  
  # services = {
  #   qemuGuest.enable = true;
  #   spice-vdagentd.enable = true;
  # };

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
