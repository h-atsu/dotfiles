{ ... }: {
  imports = [
    ./system.nix
    ./users.nix
    ./fonts.nix
    ./nix.nix
    ./homebrew.nix
    ../cli
    ../apps
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Required for user-level system.defaults (dock, finder, NSGlobalDomain)
  system.primaryUser = "atsu";

  # Used for backwards compatibility — don't change this
  system.stateVersion = 6;
}
