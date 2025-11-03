{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    image = ../../wallpapers/pacman-nord.jpg;
    polarity = "dark";

    targets = {
      gtk.enable = true;
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
        name = "CaskaydiaMono Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
      sansSerif = {
        name = "CaskaydiaMono Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
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
  };
}
