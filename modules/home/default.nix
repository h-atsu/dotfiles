{ pkgs, ... }: {
  imports = [
    ./wezterm.nix
    ./emacs.nix
  ];

  home.username = "atsu";
  home.homeDirectory = "/Users/atsu";

  # Don't change this
  home.stateVersion = "24.11";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
