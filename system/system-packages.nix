{
  pkgs,
  hostName,
  ...
}:
{
  environment.systemPackages =
    let
      common = with pkgs; [
        home-manager

        xdg-desktop-portal-hyprland
        xdg-utils
        xwayland-satellite

        pipewire
        wireplumber
        libnotify
        jq

        ruff
        sqlite
        cmake

        lm_sensors
      ];

      hostSpecific = {
        desktop = [ ];
        laptop = [ ];
      };
    in
    common ++ (hostSpecific.${hostName} or [ ]);

  services.xserver.excludePackages = [ pkgs.xterm ];

  fonts.packages = with pkgs; [
    maple-mono.NF
    noto-fonts
    nerd-fonts.caskaydia-mono
    nerd-fonts.meslo-lg
    nerd-fonts.arimo
    excalifont
    material-symbols
  ];
}
