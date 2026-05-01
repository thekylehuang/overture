{ pkgs, ... }: {
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";
  home.packages = [
    pkgs.fnm
    pkgs.pnpm
  ];
 
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
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

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)" 
    '';
  };

  programs.starship = {
    enable = true;
  };
}
