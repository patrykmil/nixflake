{
  programs.wofi = {
    enable = true;
    settings = {
      prompt = "Apps";
    };

    style = ''
      * {
        font-size: 1.04em;
        border-radius: 0;
      }

      #input {
        font-size: 2em;
        color: white;
      }

      #entry:selected {
        border: 3px solid white;
      }
    '';
  };
}
