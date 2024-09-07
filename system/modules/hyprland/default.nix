{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland = {
    enable = mkEnableOption "Enable Hyprland and LY login manager";
  };

  config = mkIf cfg.enable {
    services.displayManager = {
      ly = {
        enable = true;
      };
    };
    programs.hyprland.enable = true;
    # programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
}
