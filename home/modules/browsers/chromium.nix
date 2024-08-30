{ config, lib, ... }:

with lib;

let
  cfg = config.modules.browsers.chromium;
in {
  options.modules.browsers.chromium = {
    enable = mkEnableOption "Enable Chromium";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.chromium ];
  };
}