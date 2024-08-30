{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.module;
in {
  options.module = {
    enable = mkEnableOption "Enable module";
  };

  config = mkIf cfg.enable {
  };
}