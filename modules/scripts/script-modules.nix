{ pkgs, ... }:
let
  wallpaperSchedule = pkgs.writeShellScriptBin "wallpaperSchedule" ''
    exec "${toString ./.}/wallpaper-schedule.py" "$@"
  '';
in
{
  imports = [
    ./screenshot.nix
    ./monitor-toggle.nix
    ./getenv.nix
    ./zipignore.nix
    ./unstore.nix
  ];

  home.packages = [
    (pkgs.writeScriptBin "bright" ''
      exec "${toString ./.}/brightness.py" "$@"
    '')
    (pkgs.writeScriptBin "idleInhibitor" ''
      exec "${toString ./.}/idle-inhibitor.py" "$@"
    '')
    wallpaperSchedule
  ];

  systemd.user.services.wallpaper-schedule = {
    Unit = {
      Description = "Set wallpaper based on current hour";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperSchedule}/bin/wallpaperSchedule";
    };
  };

  systemd.user.timers.wallpaper-schedule = {
    Unit = {
      Description = "Run wallpaper-schedule every hour";
    };
    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  xdg.configFile."fish/completions/bright.fish".source = ./completions/bright.fish;
  xdg.configFile."fish/completions/idleInhibitor.fish".source = ./completions/idleInhibitor.fish;
  xdg.configFile."fish/completions/screencapture.fish".source = ./completions/screencapture.fish;
  xdg.configFile."fish/completions/monitorToggle.fish".source = ./completions/monitorToggle.fish;
}
