{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.misc.tradingview;
in
{
  options.modules.misc.tradingview = {
    enable = mkEnableOption "Enable TradingView";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.tradingview ];
  };
}
