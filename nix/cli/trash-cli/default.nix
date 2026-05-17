{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.trash-cli
  ];
}
