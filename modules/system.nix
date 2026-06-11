{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    ffmpeg
    fzf
    imagemagick
    lazygit
    typst
    qemu
    ripgrep
    russ
    tree-sitter
    uv
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
