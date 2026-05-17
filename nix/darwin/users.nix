{ ... }: {
  # User definition (home-manager needs this for homeDirectory resolution).
  users.users.atsu = {
    name = "atsu";
    home = "/Users/atsu";
  };
}
