{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.misc.anytype;
in {
  options.modules.misc.anytype = {
    enable = mkEnableOption "Enable Anytype";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.anytype ];
  };
}