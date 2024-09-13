{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.nix;
in
{
  options.modules.nix = {
    enable = mkEnableOption "Enable sensible nix options";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "/home/mizuuu/repos/nixos-config";
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
    programs.nix-ld.enable = true;
    nix.settings.auto-optimise-store = true;
    nix.gc.automatic = true;
    nix.gc.dates = "daily";
    nix.gc.options = "--delete-older-than +6";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
