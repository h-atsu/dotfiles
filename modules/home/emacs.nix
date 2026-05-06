{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;
  };

  home.file.".emacs.d/init.el".source = ../../config/emacs/init.el;
}
