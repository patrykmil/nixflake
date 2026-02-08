{ hostName, ... }:
{
  networking.networkmanager.enable = true;
  networking.hostName = hostName;
  networking.networkmanager.wifi.backend = "wpa_supplicant";
  networking.networkmanager.settings = {
    connection = {
      "wifi.powersave" = "2";
    };
  };
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
}
