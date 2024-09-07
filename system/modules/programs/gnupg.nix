{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.programs.gnupg;
in
{
  options.modules.programs.gnupg = {
    enable = mkEnableOption "Enable GNUPG";
  };

  config = mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry.gnome3;
      enableSSHSupport = true;
    };
  };
}
