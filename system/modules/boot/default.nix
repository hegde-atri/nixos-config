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
    enable = mkEnableOption "Enable systemd-boot";
  };

  config = mkIf cfg.enable {
    # boot.kernelModules = [ "kvm-amd" ];
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
