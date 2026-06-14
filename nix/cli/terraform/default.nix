{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.terraform
  ];
}
