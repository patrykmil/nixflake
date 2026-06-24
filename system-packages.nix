{
  pkgs,
  hostName,
  inputs,
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
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        adw-gtk3
      ];

      hostSpecific = {
        desktop = with pkgs; [ ];
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
    noto-fonts-cjk-sans
    excalifont
    material-symbols
  ];
}
