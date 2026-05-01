{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.git
    pkgs.neovim
    pkgs.btop
    pkgs.fastfetch
    pkgs.ffmpeg
    pkgs.gnupg
    pkgs.imagemagick
    pkgs.lazygit
    pkgs.starship
    pkgs.tmux
    pkgs.yazi
    pkgs.typst
    pkgs.pinentry-curses
  ];
  
  programs.zsh.enable = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };
  };

  system.stateVersion = 6;
}
