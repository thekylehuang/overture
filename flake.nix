{
  description = "A nix-darwin configuration for Overture, a MacOS configuration by Kyle Huang.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, fenix }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.overlays = [ fenix.overlays.default ];

      # let Determinate own Nix
      nix.enable = false;

      nixpkgs.hostPlatform = "aarch64-darwin";

      system.configurationRevision = self.rev or self.dirtyRev or null;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.kylehuang = import ./modules/home.nix;
      home-manager.backupFileExtension = "backup";
      
      system.primaryUser = "kylehuang";
      users.users.kylehuang = {
        name = "kylehuang";
        home = "/Users/kylehuang";
      };
    };
  in
  {
    darwinConfigurations."Overture-by-Kyle" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./modules/system.nix
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
