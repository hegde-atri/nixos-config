# Author: Atri Hegde <iamatrihegde@outlook.com>
# URL:    https://github.com/hegde-atri/nixos-config

# Heart of my dotfiles

{
  description = "*Laughs in nix*";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extras
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let 
      inherit (lib.my) mapModules mapModulesRec mapHosts;
      system = "x86_64-linux";
      mkPkgs = pkgs: extraOverlays: import nixpkgs {
        inherit system;
        config.allowUnfree = true; # forgive me lord for I have sinned.
        overlays = extraOverlays ++ (lib.attrValues self.overlays);
      };
      pkgs = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [];
      # add my lib to lib.
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;
      overlay = 
        final: prev: {
          unstable = pkgs';
          my = self.packages."${system}"
        };
      overlays = mapModules ./overlays import;
      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p {});
      nixosModules = { dotfiles = import ./.; } // mapModules ./modules import;
      nixosConfigurations = mapHosts ./hosts {};
      dev.Shell."${system}" = import ./shell.nix { inherit pkgs; };

      # nixosConfigurations = {
      #   # Host: Thinkpad
      #   thinkpad = lib.nixosSystem {
      #     inherit system;
      #     modules = [ 
      #       ./configuration.nix
      #       hyprland.nixosModules.default {
      #         programs.hyprland.enable = true;
      #       }
      #       home-manager.nixosModules.home-manager {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.mizuuu = {
      #           imports = [ ./home.nix ];
      #         };
      #       }
      #     ];
      #   };
      # };
    };
}
