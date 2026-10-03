{ pkgs-unstable, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  home.packages = with pkgs-unstable; [
    opencode
  ];

  xdg.configFile."opencode/tui.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/tui.jsonc";

  xdg.configFile."opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/opencode.jsonc";
}
