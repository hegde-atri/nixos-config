{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.misc.obsidian;
in {
  options.modules.misc.obsidian = {
    enable = mkEnableOption "Enable Obsidian";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.obsidian ];
  };
}