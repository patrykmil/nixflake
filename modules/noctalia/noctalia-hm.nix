{ pkgs, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{

  xdg.configFile."noctalia/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/noctalia/noctalia.toml";

}
