{ pkgs, ... }:
{
  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      favicon_service = "twenty";
      search_files_in_root = false;
      pop_to_root_on_close = true;
      font = {
        normal = {
          size = 11;
          normal = "Maple Mono NF";
        };
      };
      theme.name = "rose-pine";
      theme = {
        light = {
          name = "rose-pine";
          icon_theme = "Adwaita";
        };
        dark = {
          name = "rose-pine";
          icon_theme = "Adwaita";
        };
      };
      launcher_window = {
        opacity = 1;
      };
      # window = {
      #   csd = true;
      #   opacity = 1;
      #   rounding = 10;
      # };
    };
  };
}
