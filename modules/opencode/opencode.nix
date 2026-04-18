{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    opencode
  ];

  xdg.configFile."opencode/tui.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "/home/ptrk/flakes/modules/opencode/tui.jsonc";

  xdg.configFile."opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "/home/ptrk/flakes/modules/opencode/opencode.jsonc";
}
