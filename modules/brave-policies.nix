{ hostName, ... }:
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
      ${
        if hostName == "laptop" then
          ''
            "DnsOverHttpsMode": "secure",
            "DnsOverHttpsTemplates": "https://dnsforge.de/dns-query"
          ''
        else
          ""
      }
    }
  '';
}

# "DnsOverHttpsMode": "secure",
# "DnsOverHttpsTemplates": "https://dnsforge.de/dns-query"
# "DnsOverHttpsTemplates": "https://base.dns.mullvad.net/dns-query"
# "DnsOverHttpsTemplates": "https://security.cloudflare-dns.com/dns-query"
