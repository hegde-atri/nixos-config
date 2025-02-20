{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.intellij;
in
{
  options.modules.editors.intellij = {
    enable = mkEnableOption "Enable Intellij support";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains-toolbox ];
  };
}
