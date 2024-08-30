{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.misc.ticktick;
in {
  options.modules.misc.ticktick = {
    enable = mkEnableOption "Enable TickTick";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.ticktick ];
  };
}