{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.programs.zsh;
in
{
  options.modules.programs.zsh = {
    enable = mkEnableOption "Enable ZSH Support";
  };

  config = mkIf cfg.enable {
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh.enable = true;
  };
}
