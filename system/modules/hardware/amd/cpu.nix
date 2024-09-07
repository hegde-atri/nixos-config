{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.amd.cpu;
in
{
  options.modules.hardware.amd.cpu = {
    enable = mkEnableOption "Enable AMD CPU options";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "amd_pstate=guided" ];
    hardware.cpu.amd.updateMicrocode = true;
  };
}
