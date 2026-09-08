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

  # Lua entrypoints are out-of-store symlinks, so they cannot interpolate the
  # plugin store path. This tiny generated file bridges that gap; it is
  # loaded via pcall(require, "nix-plugins") from hyprland-common.lua.
  xdg.configFile."hypr/nix-plugins.lua".text = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
      hl.exec_cmd("hyprctl plugin load ${gloview}/lib/libgloview.so")
    end)
  '';
}
