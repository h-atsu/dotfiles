{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.mise
  ];

  home-manager.users.atsu = {config, ...}: {
    xdg.configFile."mise/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/nix/cli/mise/config.toml";

    programs.zsh.initContent = lib.mkAfter ''
      eval "$(${pkgs.mise}/bin/mise activate zsh)"
    '';
  };
}
