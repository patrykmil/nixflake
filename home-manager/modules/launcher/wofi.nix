{
  programs.wofi = {
    enable = true;
    settings = {
      prompt = "Apps";
    };
    style = ''
       ::root{
        --accent: #5291e2;
        --dark:   #383C4A;
       }

      *{
        font-family: CaskaydiaMono Nerd Font Mono;
        font-size: 1.04em;
      }

      window{
        background-color: var(--light);
      }

      #input {
        margin: 5px;
        border-radius: 0px;
        border: none;
        border-bottom: 3px solid grey;
        background-color: var(--dark);
        color: white;
        font-size: 2em;
      }

      #inner-box {
        background-color: var(--dark);
      }

      #outer-box {

        margin: 2px;
        padding:0px;
        background-color: var(--dark);
      }

      #text {
        padding: 5px;
        color: white;
      }

      #entry:selected {
        background-color: var(--accent);
      }

      #text:selected {
      }

      #scroll {
      }

      #img {
      }
    '';
  };
}
