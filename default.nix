{ inputs, config, lib, pkgs, ...}:

with lib;
with lib.my;
{
  imports = 
    # Home manager to deploy dots to $HOME.
    [ inputs.home-manager.nixosModules.home-manager ]
    # All personal modules
    ++ (mapModulesRec' (toString ./modules) import);

    # Common config for all machiens.
    environment.variables.DOTFILES = config.dotfiles.dir;
    environment.variables.DOTFILES_BIN = config.dotfiles.binDir;

    # Configure nix and nixpkgs
    environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
    # TODO:

}