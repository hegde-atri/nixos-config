{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.browsers.zen;
in
{
  options.modules.browsers.zen = {
    enable = mkEnableOption "Enable Zen";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
  };
}
