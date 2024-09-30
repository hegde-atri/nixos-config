{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.android-studio;
in
{
  options.modules.editors.android-studio = {
    enable = mkEnableOption "Enable Android Studio support";
  };

  config = mkIf cfg.enable {
    nixpkgs.config = {
      android_sdk.accept_license = true;
    };

    home.packages = [ pkgs.android-studio ];
  };
}
