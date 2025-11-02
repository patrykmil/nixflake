{
  pkgs,
  hostName,
  inputs,
  ...
}:
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;
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
    # extensions = [
    #   (inputs.vicinae.mkVicinaeExtension.${pkgs.system} {
    #     inherit pkgs;
    #     name = "wifi-commander";
    #     src =
    #       pkgs.fetchFromGitHub {
    #         owner = "vicinaehq";
    #         repo = "extensions";
    #         rev = "main"; # or a specific tag/commit
    #         sha256 = "sha256-gTkJL9T1oERLlp++7nzpCxVdADbkK01qf5RMd9zLmJs=";
    #       }
    #       + "/extensions/wifi-commander";
    #   })
    # ];
  };

}
