{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.boot;
in
{
  options.modules.boot = {
    enable = mkEnableOption "Enable GRUB2";
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      extraConfig = ''
        GRUB_SAVEDEFAULT=true
      '';
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
