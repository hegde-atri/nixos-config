{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.misc.remnote;
in
{
  options.modules.misc.remnote = {
    enable = mkEnableOption "Enable Remnote";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.remnote ];
  };
}
