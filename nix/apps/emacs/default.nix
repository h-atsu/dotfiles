_: {
  homebrew.casks = [
    "emacs-app"
  ];

  home-manager.users.atsu = {config, ...}: {
    home.file = {
      ".emacs.d/init.el".source =
        config.lib.file.mkOutOfStoreSymlink
        "/Users/atsu/dotfiles/nix/apps/emacs/init.el";

      ".local/bin/emacs".source =
        config.lib.file.mkOutOfStoreSymlink
        "/Applications/Emacs.app/Contents/MacOS/Emacs";

      ".local/bin/emacsclient".source =
        config.lib.file.mkOutOfStoreSymlink
        "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient";
    };
  };
}
