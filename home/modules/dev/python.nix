{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.dev.python;
in
{
  options.modules.dev.python = {
    enable = mkEnableOption "Enable Python Dev Tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      black
      poetry
    ];
  };
}
