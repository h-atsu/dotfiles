{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.mise
  ];

  home-manager.users.atsu = {
    xdg.configFile."mise/config.toml".source = ./config.toml;

    programs.zsh.initContent = lib.mkAfter ''
      eval "$(${pkgs.mise}/bin/mise activate zsh)"
    '';
  };
}
