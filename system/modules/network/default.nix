{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.network;
in
{
  options.modules.network = {
    enable = mkEnableOption "Enable networking";
  };

  config = mkIf cfg.enable { networking.networkmanager.enable = true; };
}
