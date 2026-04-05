{ pkgs, ... }:
{
  imports = [
    ./screenshot.nix
    ./monitor-toggle.nix
    ./getenv.nix
  ];

  home.packages = [
    (pkgs.writeScriptBin "bright" ''
      exec "${toString ./.}/brightness.py" "$@"
    '')
    (pkgs.writeScriptBin "idleInhibitor" ''
      exec "${toString ./.}/idle-inhibitor.py" "$@"
    '')
  ];

  xdg.configFile."fish/completions/bright.fish".source = ./completions/bright.fish;
  xdg.configFile."fish/completions/idleInhibitor.fish".source = ./completions/idleInhibitor.fish;
  xdg.configFile."fish/completions/screencapture.fish".source = ./completions/screencapture.fish;
  xdg.configFile."fish/completions/monitorToggle.fish".source = ./completions/monitorToggle.fish;
}
