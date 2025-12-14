{ pkgs, ... }:
{
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
    settings = {
      positionX = "right";
      positionY = "bottom";
      control-center-positionX = "left";
      control-center-positionY = "center";
      layer-shell = true;
      layer = "top";
      control-center-margin-top = 50;
      control-center-margin-bottom = 50;
      control-center-margin-right = 50;
      control-center-margin-left = 50;
      hide-on-clear = true;
      transition-time = 200;
      widgets = [
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          "text" = "Notifications";
          "clear-all-button" = true;
          "button-text" = "Clear All";
        };
        "dnd" = {
          "text" = "Do Not Disturb";
        };
        "label" = {
          "max-lines" = 5;
          "text" = "Label Text";
        };
      };
    };
    style = ''
      .notification-content {
        border: 0;
        padding: 8px;
      }
      .notification-action {
        padding: 4px;
      }
    '';
  };
}
