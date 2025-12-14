{ pkgs, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      faviconService = "twenty";
      font.normal = "Maple Mono NF";
      font.size = 11;
      popToRootOnClose = true;
      rootSearch.searchFiles = false;
      theme.name = "rose-pine";
      theme.iconTheme = "iconTheme";
      window = {
        csd = true;
        opacity = 1;
        rounding = 10;
      };
    };
  };
}
