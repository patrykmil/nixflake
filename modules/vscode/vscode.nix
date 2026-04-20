{ pkgs, config, ... }:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  home.packages = with pkgs; [
    vscode-fhs
    (pkgs.writeShellScriptBin "updateCodeExtensionsList" ''
      #!/usr/bin/env bash
      code --list-extensions > ${flakeDir}/modules/vscode/vscode-extensions.txt
    '')
    (pkgs.writeShellScriptBin "installCodeExtensions" ''
      #!/usr/bin/env bash
      xargs -n 1 code --install-extension < ${flakeDir}/modules/vscode/vscode-extensions.txt
    '')
  ];

  xdg.configFile."Code/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/vscode/vscode-settings.jsonc";

  xdg.configFile."Code/User/keybindings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/vscode/vscode-keybindings.jsonc";

}
