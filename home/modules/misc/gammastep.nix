{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.misc.gammastep;
in
{
  options.modules.misc.gammastep = {
    enable = mkEnableOption "Enable Gammastep";
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      latitude = 55.7;
      longitude = 12.6;
      temperature = {
        day = 4900;
        night = 4900;
      };
    };
  };
}
