{
  programs.git = {
    enable = true;
    userName = "patrykmil";
    userEmail = "patryk.miler@student.pk.edu.pl";
    extraConfig = {
      core.editor = "hx";
      pull.rebase = "true";
      init.defaultBranch = "main";
    };
  };
}
