{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "/${pkgs.wezterm}/bin/wezterm";
    plugins = with pkgs; [
      rofi-calc
      rofi-power-menu
      rofi-screenshot
      rofi-network-manager
    ];
    extraConfig = {
      font = "Excalifont 20";
      modi = "drun,window,run,filebrowser,calc,";
      show-icons = true;
      drun-display-format = " {name}";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-filebrowser = "   File ";
      display-window = "  Windows ";
      display-calc = " 󰪚 Calc ";
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "screenshot-menu" ''
      exec ${pkgs.rofi-screenshot}/bin/rofi-screenshot
    '')
    (pkgs.writeShellScriptBin "power-menu" ''
      rofi -show powermenu -modi powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu
    '')
    (pkgs.writeShellScriptBin "network-menu" ''
      exec ${pkgs.rofi-network-manager}/bin/rofi-network-manager
    '')
    (pkgs.writeShellScriptBin "calc" ''
      rofi -show calc -modi calc -no-show-match -no-sort
    '')
  ];
}
