{ pkgs, ... }:
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "k";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];

    style = ''
      window {
        background-color: rgba(40, 40, 40, 0.1);
      }
      button {
        background-color: #1b1e2b;
        color: #a6accd;
        border-radius: 12px;
        border: 2px solid #3e445e;
        font-family: "MesloLGS NF", monospace;
        font-size: 1.2em;
        margin: 12px;
        padding: 18px 18px;
        transition: background 0.2s, color 0.2s;
      }
      button:hover {
        background-color: #3e445e;
        color: #ffad66;
        border-color: #ffad66;
      }
      #shutdown, #suspend, #logout {
        color: #add7ff;
      }
      #lock, #reboot, #hibernate {
        color: #c4a7e7;
      }
    '';
  };
}
