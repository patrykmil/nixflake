{ ... }:
{
  services.udev.extraRules = ''
    # ATK / VXE / VGN WebHID (hub.atk.pro): let browser open hidraw read-write
    # ponytail: 0666 instead of logind ACLs, which silently no-op on this box
    KERNEL=="hidraw*", ATTRS{idVendor}=="373b", MODE:="0666", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3554", MODE:="0666", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="25a7", MODE:="0666", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373b", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3554", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="25a7", TAG+="uaccess"
    # keep this unit's 2.4GHz dongle (3554:f58a) awake: no USB autosuspend
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f58a", ATTR{power/control}="on"
  '';
}
