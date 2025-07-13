{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    # iconTheme = {
    #   name = "Breeze Dark";
    #   package = pkgs.kdePackages.breeze-icons;
    # };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    iconTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };

  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = [
    (pkgs.writeShellScriptBin "pavucontrol-dark" ''
      export GTK_THEME=Adwaita-dark
      exec ${pkgs.pavucontrol}/bin/pavucontrol "$@"
    '')
  ];

  home.sessionVariables = {
    GTK_THEME = "palenight";
    QT_QPA_PLATFORMTHEME = "gtk2";
    QT_STYLE_OVERRIDE = "palenight";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_THEME_VARIANT = "dark";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
