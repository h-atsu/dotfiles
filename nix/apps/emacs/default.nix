{ ... }: {
  homebrew.casks = [
    "emacs-app"
  ];

  home-manager.users.atsu = { config, ... }: {
    home.file.".emacs.d/init.el".source =
      config.lib.file.mkOutOfStoreSymlink
        "/Users/atsu/dotfiles/nix/apps/emacs/init.el";
  };
}
