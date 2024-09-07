{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.amd.graphics;
in
{
  options.modules.hardware.amd.graphics = {
    enable = mkEnableOption "Enable AMD graphics drivers";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = [];
      # extraPackages32 = [];
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
