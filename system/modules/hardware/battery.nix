{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.battery;
in
{
  options.modules.hardware.battery = {
    enable = mkEnableOption "Enable UPower support for battery";
  };

  config = mkIf cfg.enable {
    services.upower = {
      enable = true;
    };
  };
}
