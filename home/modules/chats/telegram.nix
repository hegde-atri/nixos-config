{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.chats.telegram;
in {
  options.modules.chats.telegram = {
    enable = mkEnableOption "Enable Telegram Desktop";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.telegram-desktop ];
  };
}