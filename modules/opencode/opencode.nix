{ pkgs-unstable, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
  opencode-v2 = pkgs-unstable.callPackage ./package.nix { };
in
{

  # home.packages = with pkgs-unstable; [
  #   opencode
  # ];

  home.packages = [ opencode-v2 ];

  xdg.configFile."opencode/tui.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/tui.jsonc";

  xdg.configFile."opencode/cli.json".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/cli.json";

  xdg.configFile."opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/opencode.jsonc";
}
