{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.zsh;
in
{
  options.modules.zsh = {
    enable = mkEnableOption "Enable Docker Support";
  };

  config = mkIf cfg.enable {
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh.enable = true;
  };
}
