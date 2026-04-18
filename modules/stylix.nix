{
  pkgs,
  lib,
  inputs,
  fonts,
  ...
}:
{

  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-dune.yaml";
    override = {
      base0D = "#40a02b";
    };

    # image = ../../wallpapers/pacman-nord.jpg;
    # polarity = "dark";

    targets = {
      gtk = {
        enable = true;
        extraCss = ''
          .dialog-action-area > .text-button {
            color: @dialog_fg_color;
          }
        '';
      };
      wezterm.enable = false;
      waybar.font = "serif";
      vicinae.enable = false;
      # hyprpaper.enable = lib.mkDefault false;
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 21;
    };

    fonts = {
      monospace = {
        name = fonts.monospace;
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
      serif = {
        name = fonts.serif;
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
      sansSerif = {
        name = fonts.sansSerif;
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
    };

    icons = {
      enable = true;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
      # package = pkgs.catppuccin-papirus-folders;
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "latte";
        accent = "green";
      };
    };

  };
}
