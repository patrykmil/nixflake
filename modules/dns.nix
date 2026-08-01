{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ nextdns ];

  services.nextdns = {
    enable = true;
    arguments = [
      "-config"
      "2fc3af"
      "-cache-size"
      "30MB"
    ];
  };

  systemd.services.nextdns-activate = {
    script = ''
      /run/current-system/sw/bin/nextdns activate
    '';
    after = [ "nextdns.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}
