{
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 53317;
        to = 53318;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
