{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # forgive me lord for I have sinned.
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        # Host name of the system
        thinkpad = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            hyprland.nixosModules.default {
              programs.hyprland.enable = true;
            };
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mizuuu = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
