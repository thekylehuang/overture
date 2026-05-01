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
    pkgs.zsh-syntax-highlighting
    pkgs.typst
  ];

  programs.zsh.enable = true;
  programs.zsh.enableSyntaxHighlighting = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };
  };

  system.stateVersion = 6;
}
