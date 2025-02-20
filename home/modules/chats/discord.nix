{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.chats.discord;
in
{
  options.modules.chats.discord = {
    enable = mkEnableOption "Enable Discord (Webcord: wayland support)";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.webcord ];
  };
}
