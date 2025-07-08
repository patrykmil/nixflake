{
  programs.fish = {
    enable = true;
    shellAliases = {
      his = "history | tac";
      cc = "clear";
      zj = "zellij";
      e = "eza --icons=always -a -l --git -B";
      es = "eza --icons=always -a -l --git -B --total-size";
      et = "eza --icons=auto -T -L=4 -a -l --git -B --no-filesize --no-permissions --octal-permissions --no-user --no-time --git-ignore";
    };
    functions = {
      fish_greeting = "";
    };
  };

  programs.fzf.enableFishIntegration = true;
  programs.zoxide.enableFishIntegration = true;
}
