{pkgs, ...}: {
  homebrew.casks = [
    "visual-studio-code"
  ];

  home-manager.users.atsu = {config, ...}: {
    programs.vscode = {
      enable = true;
      package = null;
      mutableExtensionsDir = true;

      profiles.default = {
        keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
        globalSnippets = builtins.fromJSON (builtins.readFile ./snippets/global.code-snippets);

        extensions = with pkgs.vscode-extensions; [
          charliermarsh.ruff
          ms-python.python
          ms-python.vscode-pylance
          rust-lang.rust-analyzer
          yzhang.markdown-all-in-one
          gruntfuggly.todo-tree
          pkief.material-icon-theme
          dracula-theme.theme-dracula
          tuttieee.emacs-mcx
          ms-vscode-remote.remote-ssh
          hediet.vscode-drawio
        ];
      };
    };

    home.file."Library/Application Support/Code/User/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/nix/apps/visual-studio-code/settings.json";
  };
}
