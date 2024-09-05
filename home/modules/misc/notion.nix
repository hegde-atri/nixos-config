{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.misc.notion;
in {
  options.modules.misc.notion = {
    enable = mkEnableOption "Enable Notion Enhanced";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.notion-app-enhanced ];
  };
}