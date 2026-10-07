{
  config,
  pkgs-unstable,
  hostClass,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  home.packages = with pkgs-unstable; [
    sunsetr
  ];

  # Tiny generated entrypoint; real config stays symlinked so Umbriel
  # live-reloads on save. noctalia.toml is pre-declared here because this
  # file is read-only in the store — Noctalia can't add the include itself,
  # it only writes noctalia.toml (enable the Umbriel template in Settings).
  xdg.configFile."umbriel/config.toml".text = ''
    [include]
    files = ["umbriel-common.toml", "umbriel-${hostClass}.toml"]

    [include.optional]
    files = ["~/.config/umbriel/noctalia.toml"]
  '';

  xdg.configFile."umbriel/umbriel-common.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/umbriel/umbriel-common.toml";

  xdg.configFile."umbriel/umbriel-${hostClass}.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/umbriel/umbriel-${hostClass}.toml";
}
