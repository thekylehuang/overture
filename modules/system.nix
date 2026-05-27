{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    pkgs.fenix.stable.rust-analyzer

    pkgs.btop
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.gnupg
    pkgs.imagemagick
    pkgs.lazygit
    pkgs.typst
    pkgs.pinentry-curses
    pkgs.qemu
    pkgs.ripgrep
    pkgs.russ
    pkgs.tree-sitter
    pkgs.uv
    
    pkgs.lua-language-server
    pkgs.pyright
    pkgs.typescript-language-server
    pkgs.tinymist
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
