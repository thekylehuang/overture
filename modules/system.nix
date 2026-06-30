{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ffmpeg
    ghostty-bin
    imagemagick
    just
    nmap
    typst
    qemu
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
