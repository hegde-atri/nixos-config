{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.proton.mail;
in
{
  options.modules.proton.mail = {
    enable = mkEnableOption "Enable Proton Mail App";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.protonmail-desktop ]; };
}
