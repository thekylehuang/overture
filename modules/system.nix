{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    ffmpeg
    fzf
    ghostty-bin
    imagemagick
    lazygit
    nmap
    typst
    qemu
    ripgrep
    russ
    tree-sitter
    uv
    yt-dlp
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
