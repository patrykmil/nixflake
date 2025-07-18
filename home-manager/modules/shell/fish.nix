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
      nrs = "sudo nixos-rebuild switch --flake /home/ptrk/flakes";
      hms = "home-manager switch --flake /home/ptrk/flakes -b backup";

    };
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
}
