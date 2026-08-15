{ inputs, pkgs, pkgs-unstable, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";

  gloview = pkgs-unstable.hyprlandPlugins.mkHyprlandPlugin {
    pluginName = "gloview";
    version = "0.3.0";
    src = inputs.gloview;

    nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];
    buildInputs = [ pkgs.luajit ];

    postInstall = ''
      ln -sf gloview.so "$out/lib/libgloview.so"
    '';

    meta = {
      description = "macOS Mission Control-style overview for Hyprland";
      homepage = "https://github.com/fedsfarm/gloview";
      license = pkgs.lib.licenses.gpl3Plus;
    };
  };
in
{
  wayland.windowManager.hyprland = {
    plugins = [ gloview ];
  };

    xdg.configFile."hypr/gloview.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/hyprland/gloview.conf";
}
