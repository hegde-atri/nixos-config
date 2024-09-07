{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.services.printing;
in
{
  options.modules.services.printing = {
    enable = mkEnableOption "Enable Printing Services";
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      startWhenNeeded = true;
      drivers = with pkgs; [ hplip ];
      cups-pdf.enable = true;
    };
  };
}
