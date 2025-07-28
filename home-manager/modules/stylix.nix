{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maple-mono.NF
    noto-fonts
    nerd-fonts.caskaydia-mono
    nerd-fonts.meslo-lg
    nerd-fonts.arimo
    excalifont
    qogir-icon-theme
  ];

  stylix = {
    enable = true;
    image = ./wallpaper/wallpapers/deer-forest.jpg;
    polarity = "dark";

    targets = {
      # waybar.enable = false;
      wezterm.enable = false;
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 21;
    };

    fonts = {
      monospace = {
        name = "CaskaydiaMono Nerd Font Mono";
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sansSerif = {
        name = "Arimo Nerd Font";
        package = pkgs.nerd-fonts.arimo;
      };
    };

    iconTheme = {
      enable = true;
      light = "Qogir";
      dark = "Qogir";
      package = pkgs.qogir-icon-theme;
    };
  };
}
