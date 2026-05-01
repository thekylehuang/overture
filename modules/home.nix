{ pkgs, ... }: {
  home.stateVersion = "26.05";
  home.username = "kylehuang";
  home.homeDirectory = "/Users/kylehuang";
  
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
}
