{
  home.file.".config/scripts/toggle-second-monitor.sh" = {
    executable = true;
    text = builtins.readFile ./scripts/toggle-second-monitor.sh;
  };

  home.file.".config/scripts/screenshot.sh" = {
    executable = true;
    text = builtins.readFile ./scripts/screenshot.sh;
  };

  home.file.".config/scripts/toggle-wofi.sh" = {
    executable = true;
    text = builtins.readFile ./scripts/toggle-wofi.sh;
  };
}
