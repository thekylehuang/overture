{
  description = "A nix-darwin configuration for Overture, a MacOS configuration by Kyle Huang.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    cole-nvim = {
      url = "github:thekylehuang/cole.nvim";
      flake = false;
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, ... }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.overlays = [
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            cole-nvim = final.vimUtils.buildVimPlugin {
              name = "cole-nvim";
              src = inputs.cole-nvim;
            };
          };
        })
      ];

      # let Determinate own Nix
      nix.enable = false;
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.settings.auto-optimise-store = true;

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

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "kylehuang";
        autoMigrate = true;
        taps = {
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
        };
        mutableTaps = false;
      };

      homebrew = {
        enable = true;
        taps = builtins.attrNames config.nix-homebrew.taps;
        brews = [
          "carthage"
          "swiftformat"
          "swiftgen"
          "swiftlint"
        ];
        onActivation.cleanup = "zap";
      };
    };
  in
  {
    darwinConfigurations."Overture-by-Kyle" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        ./modules/system.nix
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
      ];
    };
  };
}
