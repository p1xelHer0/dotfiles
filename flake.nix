{
  description = "p1xelHer0's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... } @ inputs:
    let
      inherit (darwin.lib) darwinSystem;

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
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
            }
          ];
        };
      };
    };
}
