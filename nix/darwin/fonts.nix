{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    plemoljp
    nerd-fonts.symbols-only
  ];
}
