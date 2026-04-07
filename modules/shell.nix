{
  config,
  pkgs,
  hostName,
  ...
}:
let
  flakeDir = "${config.home.homeDirectory}/flakes";
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      his = "history | tac";

      cc = "clear";

      e = "eza --icons=always -a -l --git -B";
      es = "eza --icons=always -a -l --git -B --total-size";
      et = "eza --icons=auto -T -L=4 -a -l --git -B --no-filesize --no-permissions --octal-permissions --no-user --no-time --git-ignore";

      rt = "trash put";
      restore = "trash list | tac | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force";
      remove = "trash list | tac | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force";
      emptytrash = "trash empty";

    }
    // (
      if hostName == "desktop" then
        {
          ss = "sudo nixos-rebuild switch --flake ${flakeDir}#desktop";
          st = "sudo nixos-rebuild test --flake ${flakeDir}#desktop";
        }
      else if hostName == "laptop" then
        {
          ss = "sudo nixos-rebuild switch --flake ${flakeDir}#laptop";
          st = "sudo nixos-rebuild test --flake ${flakeDir}#laptop";
        }
      else
        { }
    );
    functions = {
      fish_greeting = "";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.btop = {
    enable = true;
    package = if hostName == "desktop" then pkgs.btop.override { cudaSupport = true; } else pkgs.btop;
    settings = {
      graph_symbol = "block";
    }
    // (if hostName == "desktop" then { shown_boxes = "cpu mem net proc gpu0"; } else { });
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      warn_timeout = 0;
      hide_env_diffs = true;
      log_filter = "^(un)?loading";
    };
  };
}
