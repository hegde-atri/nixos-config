{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.terminal.kitty;
in {
  options.modules.terminal.kitty = {
    enable = mkEnableOption "Enable Kitty Terminal";
  };

  config = mkIf cfg.enable {
    programs.kitty.enable = true;
  };
}