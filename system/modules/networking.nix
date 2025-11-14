{ hostName, ... }:
{
  networking.networkmanager.enable = true;
  networking.hostName = hostName;
  networking.networkmanager.wifi.backend = "wpa_supplicant";
}
