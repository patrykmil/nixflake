{
  programs.git = {
    enable = true;
    userName = "patrykmil";
    userEmail = "patryk.miler@student.pk.edu.pl";
    extraConfig = {
      core.editor = "code";
      pull.rebase = "true";
      init.defaultBranch = "main";
    };
  };
}
