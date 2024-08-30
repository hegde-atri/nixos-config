{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.modules.chats.signal;
in {
  options.modules.chats.signal = {
    enable = mkEnableOption "Enable Signal Desktop App";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.signal-desktop ];
  };
}