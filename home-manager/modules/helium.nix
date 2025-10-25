{ config, pkgs, ... }:


let
	version = "0.5.7.1";
	heliumAppImage = pkgs.fetchurl {
		url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
		sha256 = "sha256:03e7cd716eee8db798a8e6fe831cd0d29d7d275e1cb1f172a24d11551171a3ad";
	};
	heliumIcon = pkgs.fetchurl {
		url = "https://github.com/imputnet/helium-chromium/raw/c8be58073466cc886546c99b984893faa9c8105d/resources/branding/product_logo.svg";
		sha256 = "7eb2b8a0b00a8ccefe2b4712c298a9c320d8bbd44f6de9133621e3f3fdd34e7a";
	};
	appimagePath = "${config.home.homeDirectory}/.local/bin/helium.AppImage";
	iconPath = "${config.home.homeDirectory}/.local/share/icons/helium.svg";
	desktopFilePath = "${config.home.homeDirectory}/.local/share/applications/helium.desktop";
in {

	home.file.".local/bin/helium.AppImage".source = heliumAppImage;
	home.file.".local/bin/helium.AppImage".executable = true;

	home.file.".local/share/icons/helium.svg".source = heliumIcon;

	home.file.".local/share/applications/helium.desktop".text = ''
		[Desktop Entry]
		Name=Helium
		Exec=${pkgs.appimage-run}/bin/appimage-run ${appimagePath}
		Icon=${iconPath}
		Type=Application
		Categories=Utility;
		Terminal=false
	'';

	home.packages = [
		(pkgs.writeShellScriptBin "helium" ''
      exec ${pkgs.appimage-run}/bin/appimage-run ${appimagePath} 
    '')
	];
}
