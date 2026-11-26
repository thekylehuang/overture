{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ffmpeg
    ghostty-bin
    imagemagick
    just
    mesa
    nmap
    prismlauncher
    qemu
    ripgrep
    russ
  ];
  
  programs.zsh.enable = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
    };

    CustomUserPreferences.NSGlobalDomain = {
      NSConvolutionOverride1 = 1.0e-6;
    };
  };

  system.stateVersion = 6;
}
