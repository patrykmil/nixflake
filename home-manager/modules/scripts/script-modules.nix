{ pkgs, ... }:
{
  imports = [
    ./screenshot.nix
    ./monitor-toggle.nix
  ];

  home.packages = [
    (pkgs.writeScriptBin "bright" ''
      exec "${toString ./.}/brightness.py" "$@"
    '')
    (pkgs.writeScriptBin "idleInhibitor" ''
      exec "${toString ./.}/idle-inhibitor.py" "$@"
    '')
  ];
}
