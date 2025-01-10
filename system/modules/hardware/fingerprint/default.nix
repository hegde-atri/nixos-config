{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.fingerprint;
in
{
  options.modules.hardware.fingerprint = {
    enable = mkEnableOption "Fingerprint support";
  };

  config = mkIf cfg.enable {
    services.fprintd = {
      enable = true;
    };
  };
}
