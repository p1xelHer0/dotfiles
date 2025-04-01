{
  description = "p1xelHer0's system";

  inputs = {
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix/2.27.1";

    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.0";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nix, nix-darwin, home-manager, ... }:
    let
      inherit (nix-darwin.lib) darwinSystem;

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
      };

      overlays = [
        # neovim-nightly-overlay.overlays.default
      ];
    in
    {
      darwinConfigurations = {
        p1xelBook = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.users.p1xelher0 = {
                nixpkgs.overlays = overlays;

                imports = [
                  ./home.nix
                ];
              };
            }
          ];
        };

        Pontuss-MacBook-Pro = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            nix.darwinModules.default
            ./work.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.users."pontus.nagy" = {
                nixpkgs.overlays = overlays;

                imports = [
                  ./work-home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
