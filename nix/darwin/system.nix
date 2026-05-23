_: {
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
        persistent-apps = [
          "/Applications/WezTerm.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Google Chrome.app"
          "/Applications/Obsidian.app"
          "/Applications/Spotify.app"
        ];
        show-recents = false;
        tilesize = 48;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
        FXPreferredViewStyle = "Nlsv"; # list view
      };

      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        "com.apple.trackpad.scaling" = 3.0;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
      };

      screencapture = {
        location = "/Users/atsu/Pictures/Screenshots";
        target = "file";
      };

      trackpad = {
        Clicking = true;
      };

      # Keep input source switching on Command-Space and disable the conflicting
      # Spotlight binding so the shortcut survives machine migration.
      CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        "60" = {
          enabled = true;
          value = {
            parameters = [32 49 1048576];
            type = "standard";
          };
        };
        "61" = {
          enabled = false;
          value = {
            parameters = [32 49 786432];
            type = "standard";
          };
        };
        "64" = {
          enabled = false;
          value = {
            parameters = [32 49 1048576];
            type = "standard";
          };
        };
        "65" = {
          enabled = true;
          value = {
            parameters = [32 49 1572864];
            type = "standard";
          };
        };
      };
    };

    activationScripts.configureScreenshotDirectory.text = ''
      mkdir -p /Users/atsu/Pictures/Screenshots
      chown atsu:staff /Users/atsu/Pictures/Screenshots
      killall SystemUIServer 2>/dev/null || true
    '';
  };
}
