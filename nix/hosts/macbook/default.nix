{inputs, ...}: [
  ../../darwin
  inputs.home-manager.darwinModules.home-manager
  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.atsu = import ../../home;
    };
  }
]
