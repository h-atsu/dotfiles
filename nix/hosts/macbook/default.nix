{ inputs, ... }:

[
  ../../darwin
  inputs.home-manager.darwinModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.atsu = import ../../home;
  }
]
