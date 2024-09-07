{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.programs.gnome-keyring;
in
{
  options.modules.programs.gnome-keyring = {
    enable = mkEnableOption "Enable gnome-keyring";
  };

  config = mkIf cfg.enable { services.gnome.gnome-keyring.enable = true; };
}
