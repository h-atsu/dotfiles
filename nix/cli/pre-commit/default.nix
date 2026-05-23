{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.pre-commit
  ];
}
