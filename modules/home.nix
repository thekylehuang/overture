{ pkgs, ... }: {
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";

  home.file.".config/nvim".source = ../dotfiles/nvim;

  home.packages = [
    pkgs.fnm
    pkgs.pnpm
  ];
 
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        color = {
          keys = "yellow";
          title = "39";
          separator = "yellow";
        };
      };
      logo = {
        source = "nixos";
        padding = {
          right = 6;
          top = 1;
        };
      };
      modules = [
        "break"
        "break"
        "break"
        "break"
        "break"
        "title"
        "separator"
        "os"
        "kernel"
        "uptime"
        "shell"
        "de"
        "terminal"
        "cpu"
        "gpu"
        "break"
        "colors"
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kyle Huang";
        email = "kyle@thekylehuang.org";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.iamb = {
    enable = true;
    settings = {
      profiles.user = {
        user_id = "@thekylehuang:matrix.org";
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = ''
      $directory$git_branch$git_status
      $character
      '';
      directory = {
        style = "#f2e6cf";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };
      git_branch = {
        format = "[git:$branch](#858585) ";
      };
      git_status = {
        style = "#858585";
      };
      character = {
        format = "$symbol ";
        success_symbol = "[󰘧](#b38d59) ";
        error_symbol = "[󱄅](#cc5d4b) ";
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'thekylehuang/cole-tmux'
        
      unbind '"'
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind H resize-pane -L 5
      bind J resize-pane -D 5
      bind K resize-pane -U 5
      bind L resize-pane -R 5

      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
  
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    flavors = {
      cole = ../dotfiles/yazi/flavors/cole.yazi;
    };

    theme = {
      flavor = {
        dark = "cole";
      };
    };

    settings = {
      mgr = {
        show_symlink = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)" 
    '';
  };
}
