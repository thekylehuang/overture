{ pkgs, ... }: {
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";

  home.file.".config/nvim".source = ../dotfiles/nvim;
  home.file.".config/tmux".source = ../dotfiles/tmux;

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
      logo = {
        source = "nixos";
        padding = {
          right = 2;
        };
      };
      modules = [
        "title"
        "separator"
        "os"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "de"
        "terminal"
        "cpu"
        "gpu"
        "memory"
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
