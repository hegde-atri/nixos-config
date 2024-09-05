{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.dev.go;
in
{
  options.modules.dev.go = {
    enable = mkEnableOption "Enable GoLang Dev Tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      go
      gopls
      gore
      gotools
      gotests
      gomodifytags
    ];
  };
}
