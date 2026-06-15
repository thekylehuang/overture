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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.overlays = [
        (final: prev: {
          vimPlugins = prev.vimPlugins // {
            cole-nvim = final.vimUtils.buildVimPlugin {
              name = "cole-nvim";
              src = inputs.cole-nvim;
            };
            typst-preview-nvim = prev.vimPlugins.typst-preview-nvim.overrideAttrs (old: {
              postPatch = ''
                sed -i "s/v0.14.12/v0.14.20/" lua/typst-preview/fetch.lua
                sed -i "s/'--no-open',/'--no-open',\n    '--verbose',/" lua/typst-preview/servers/factory.lua
              '';
            });
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
