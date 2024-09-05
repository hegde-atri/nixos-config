{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.proton.pass;
in
{
  options.modules.proton.pass = {
    enable = mkEnableOption "Enable Proton Pass App";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.proton-pass ]; };
}
