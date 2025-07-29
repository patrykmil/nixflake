{ pkgs, hostName, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages =
    with pkgs;
    [
      pcmanfm
      nwg-look
      vscode
      brave
      home-manager
      wl-clipboard
      grim
      slurp
      python314
      ruff
      sqlite
    ]
    ++ (
      if hostName == "desktop" then
        [

        ]
      else if hostName == "laptop" then
        [

        ]
      else
        [

        ]
    );
}
