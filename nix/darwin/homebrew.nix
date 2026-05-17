{ ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
