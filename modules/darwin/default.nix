{ pkgs, ... }: {
  imports = [
    ./system.nix
  ];

  # User definition (home-manager needs this for homeDirectory resolution)
  users.users.atsu = {
    name = "atsu";
    home = "/Users/atsu";
  };

  # Disable nix-darwin's Nix management (Determinate Nix handles this)
  nix.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages (available to all users)
  environment.systemPackages = with pkgs; [
    git
    tree
    htop
    uv
    rustup
  ];

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
    casks = [
      "docker-desktop"
      "emacs-app"
      "google-chrome"
      "visual-studio-code"
      "wezterm"
      "discord"
      "spotify"
      "raycast"
    ];
  };

  # Required for user-level system.defaults (dock, finder, NSGlobalDomain)
  system.primaryUser = "atsu";

  # Used for backwards compatibility — don't change this
  system.stateVersion = 6;
}
