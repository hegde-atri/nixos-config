{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.browsers.firefox;
in
{
  options.modules.browsers.firefox = {
    enable = mkEnableOption "Enable Firefox";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.firefox
      pkgs.firefox-devedition-bin
    ];
  };
}
