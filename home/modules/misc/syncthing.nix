{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.misc.syncthing;
in {
  options.modules.misc.syncthing = {
    enable = mkEnableOption "Enable QT";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
    };
  };
}