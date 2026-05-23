_: {
  home-manager.users.atsu = {
    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 100000;
        save = 100000;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };

      shellAliases = {
        ls = "eza --icons --group-directories-first";
        ll = "eza --icons --group-directories-first --long --git";
        la = "eza --icons --group-directories-first --all";
        lt = "eza --icons --group-directories-first --tree --level=2";
        emacs = "emacs -nw";
        rm = "trash";
      };

      initContent = ''
        setopt auto_cd
        setopt correct
        setopt extended_glob
        setopt hist_ignore_all_dups
        setopt hist_reduce_blanks
        setopt inc_append_history
        setopt share_history

        bindkey -e
      '';
    };
  };
}
