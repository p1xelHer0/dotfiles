{
  description = "p1xelHer0's system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";

    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nix-darwin, home-manager, lix-module, ... }:
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
            lix-module.nixosModules.default
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
            lix-module.nixosModules.default
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
