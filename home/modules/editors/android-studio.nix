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

    xdg.desktopEntries.android-studio = {
      name = "Android Studio";
      genericName = "Android IDE";
      exec = "env -u QT_QPA_PLATFORM android-studio %f";
      icon = "android-studio";
      terminal = false;
      categories = [
        "Development"
        "IDE"
      ];
      mimeType = [ "application/x-android-studio-project" ];
      comment = "Develop with pleasure!";
    };

    programs.zsh.shellAliases = {
      android-studio = "env -u QT_QPA_PLATFORM android-studio";
    };
  };
}
