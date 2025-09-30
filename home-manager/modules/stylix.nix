{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = ../../wallpapers/ink-wave.jpg;
    polarity = "dark";

    targets = {
      # waybar.enable = false;
      # fish.enable = false;
      wezterm.enable = false;
      # rofi.enable = false;
      gtk.enable = true;
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
        name = "Excalifont";
        package = pkgs.excalifont;
      };
      sansSerif = {
        name = "Excalifont";
        package = pkgs.excalifont;
      };
      # serif = {
      #   name = "Noto Serif";
      #   package = pkgs.noto-fonts;
      # };
      # sansSerif = {
      #   name = "Arimo Nerd Font";
      #   package = pkgs.nerd-fonts.arimo;
      # };
    };

    iconTheme = {
      enable = true;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
      # package = pkgs.catppuccin-papirus-folders.override {
      #   flavor = "mocha";
      #   accent = "blue";   # Change to your desired accent color
      # };
    };

    # iconTheme = {
    #   enable = true;
    #   light = "Qogir";
    #   dark = "Qogir";
    #   package = pkgs.qogir-icon-theme;
    # };
  };
}
