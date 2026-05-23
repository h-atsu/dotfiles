_: {
  home-manager.users.atsu = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = true;
        command_timeout = 1000;

        format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold yellow)";
        };

        directory = {
          style = "bold cyan";
          truncation_length = 3;
          truncate_to_repo = false;
        };

        git_branch = {
          symbol = "git:";
          style = "bold purple";
          format = "[$symbol$branch]($style) ";
        };

        git_status = {
          style = "bold yellow";
          format = "([$all_status$ahead_behind]($style) )";
        };

        nix_shell = {
          symbol = "nix:";
          style = "bold blue";
          format = "[$symbol$name]($style) ";
        };

        cmd_duration = {
          min_time = 1000;
          style = "bold yellow";
          format = "took [$duration]($style) ";
        };
      };
    };
  };
}
