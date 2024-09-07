{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.ssd;
in
{
  options.modules.hardware.ssd = {
    enable = mkEnableOption "Enable SSD Optimisations";
  };

  config = mkIf cfg.enable {
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}
