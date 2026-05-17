{ ... }: {
  homebrew.casks = [
    "wezterm"
  ];

  home-manager.users.atsu = { config, ... }: {
    xdg.configFile."wezterm/wezterm.lua".source =
      config.lib.file.mkOutOfStoreSymlink
        "/Users/atsu/dotfiles/nix/apps/wezterm/wezterm.lua";
  };
}
