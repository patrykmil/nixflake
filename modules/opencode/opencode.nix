{ pkgs-unstable, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";

  version = "1.18.21";
  src = pkgs-unstable.fetchFromGitHub {
    owner = "anomalyco";
    repo = "opencode";
    tag = "v${version}";
    hash = "sha256-WKG/lts+wzDjYJ5pOZ0X4Kb0rJ1TzYQzQgjyQBY+bxs=";
  };

  opencode-pinned =
    (pkgs-unstable.opencode.overrideAttrs (_: {
      inherit version src;
    })).overrideAttrs (old: {
      passthru = old.passthru // {
        node_modules = old.passthru.node_modules.overrideAttrs (_: {
          outputHash = "sha256-WqEZQCVl4oQFVbrhlWVaBW+JiSqjSK+LILPkDV9Avds=";
        });
      };
    });
in
{
  home.packages =
    with pkgs-unstable;
    [
      opencode-desktop
    ]
    ++ [ opencode-pinned ];

  xdg.configFile."opencode/tui.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/tui.jsonc";

  xdg.configFile."opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/opencode/opencode.jsonc";
}
