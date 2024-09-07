{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.environment;
in
{
  options.modules.environment = {
    enable = mkEnableOption "Enable environment options";
  };

  config = mkIf cfg.enable {
    environment.binsh = "${pkgs.dash}/bin/dash";
    environment.systemPackages = with pkgs; [ vim ];
  };
}
