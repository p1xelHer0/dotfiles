{
  description = "p1xelHer0's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... } @ inputs:
    let
      inherit (nix-darwin.lib) darwinSystem;

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.neovim-nightly-overlay.overlay
        ];
      };
    in
    {
      darwinConfigurations = rec {
        p1xelBook = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.users.p1xelher0 = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        Pontus-SAVR-MacBook = darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./work.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.users.pontusnagy = import ./work-home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
    };
}
