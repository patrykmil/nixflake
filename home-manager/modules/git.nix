{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "patryk.miler@student.pk.edu.pl";
        name = "patrykmil";
      };
      core.editor = "code";
      pull.rebase = "true";
      init.defaultBranch = "main";
      alias = {
        amend = "commit --amend --no-edit";
      };
    };
  };
}
