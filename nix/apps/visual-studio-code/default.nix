{pkgs, ...}: {
  homebrew.casks = [
    "visual-studio-code"
  ];

  home-manager.users.atsu = {
    programs.vscode = {
      enable = true;
      package = null;
      mutableExtensionsDir = true;

      profiles.default = {
        userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
        keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
        globalSnippets = builtins.fromJSON (builtins.readFile ./snippets/global.code-snippets);

        extensions = with pkgs.vscode-extensions; [
          charliermarsh.ruff
          ms-python.python
          ms-python.vscode-pylance
          rust-lang.rust-analyzer
          gruntfuggly.todo-tree
          pkief.material-icon-theme
          dracula-theme.theme-dracula
          tuttieee.emacs-mcx
          ms-vscode-remote.remote-ssh
        ];
      };
    };
  };
}
