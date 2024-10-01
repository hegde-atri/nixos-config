{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.misc.openfortivpn;
in
{
  options.modules.misc.openfortivpn = {
    enable = mkEnableOption "Enable openfortivpn";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.openfortivpn ];
    programs.zsh.shellAliases = {
      vpn = "sudo openfortivpn --pppd-accept-remote=1";
    };
  };
}
