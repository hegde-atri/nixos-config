{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.proton.vpn;
in
{
  options.modules.proton.vpn = {
    enable = mkEnableOption "Enable Proton VPN";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.protonvpn-gui ]; };
}
