{
  environment.etc."/brave/policies/managed/GroupPolicy.json".text = ''
    {
      "BraveAIChatEnabled": false,
      "BraveRewardsDisabled": true,
      "BraveWalletDisabled": true,
      "BraveVPNDisabled": true,
      "TorDisabled": true,
      "BraveP3AEnabled": false,
      "BraveStatsPingEnabled": false,
      "BraveWebDiscoveryEnabled": false,
      "BraveNewsDisabled": true,
      "BraveTalkDisabled": true,
      "SyncDisabled": false,
      "PasswordManagerEnabled": false,
      "AutofillAddressEnabled": false,
      "AutofillCreditCardEnabled": false,
      "DnsOverHttpsMode": "secure",
      "DnsOverHttpsTemplates": "https://base.dns.mullvad.net/dns-query"
    }
  '';
}

# https://base.dns.mullvad.net/dns-query
# https://security.cloudflare-dns.com/dns-query
