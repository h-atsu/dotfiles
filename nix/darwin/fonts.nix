{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    plemoljp
    nerd-fonts.symbols-only
  ];
}
