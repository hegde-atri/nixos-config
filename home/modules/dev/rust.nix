{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.dev.rust;
in
{
  options.modules.dev.rust = {
    enable = mkEnableOption "Enable Rust Dev Tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
    ];
  };
}
