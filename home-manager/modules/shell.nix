{ hostName, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      his = "history | tac";

      cc = "clear";

      e = "eza --icons=always -a -l --git -B";
      es = "eza --icons=always -a -l --git -B --total-size";
      et = "eza --icons=auto -T -L=4 -a -l --git -B --no-filesize --no-permissions --octal-permissions --no-user --no-time --git-ignore";

    }
    // (
      if hostName == "desktop" then
        {
          dss = "sudo nixos-rebuild switch --flake /home/ptrk/flakes#desktop";
          dhs = "home-manager switch --flake /home/ptrk/flakes#ptrk-desktop -b backup";
          dst = "sudo nixos-rebuild test --flake /home/ptrk/flakes#desktop";
        }
      else if hostName == "laptop" then
        {
          lss = "sudo nixos-rebuild switch --flake /home/ptrk/flakes#laptop";
          lhs = "home-manager switch --flake /home/ptrk/flakes#ptrk-laptop -b backup";
          lst = "sudo nixos-rebuild test --flake /home/ptrk/flakes#laptop";
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

  programs.btop.enable = true;

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
