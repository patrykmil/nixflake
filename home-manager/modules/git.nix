{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "patryk.miler@student.pk.edu.pl";
        name = "patrykmil";
      };
      core.editor = "hx";
      pull.rebase = "true";
      init.defaultBranch = "main";
      alias = {
        amend = "commit --amend --no-edit";
        graph = "log --graph --all";
        myclone = "!f() { git clone git@github.com:patrykmil/$1.git; }; f";
        unadd = "restore --staged";
        wdiff = "diff -w --word-diff=color --ignore-space-at-eol";
        com = "!f() { git add . && git commit -m \"$1\"; }; f";
      };
    };
  };
}
