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

    pkgs.neovim
    pkgs.btop
    pkgs.ffmpeg
    pkgs.gnupg
    pkgs.imagemagick
    pkgs.lazygit
    pkgs.typst
    pkgs.pinentry-curses
    pkgs.ripgrep
    pkgs.russ
    pkgs.uv
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
