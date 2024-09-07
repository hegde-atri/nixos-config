{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.plasma;
in
{
  options.modules.plasma = {
    enable = mkEnableOption "Enable Plasma 6";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
