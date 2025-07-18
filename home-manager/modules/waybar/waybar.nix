{ ... }:
{

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = [
      (
        {
          layer = "top";
          position = "bottom";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          height = 0;
        }
        // (import ./waybar-layout.nix)
      )
    ];
  };
}
