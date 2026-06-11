{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    fenix.stable.rust-analyzer

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
    
    astro-language-server
    lua-language-server
    pyright
    typescript-language-server
    tinymist
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
