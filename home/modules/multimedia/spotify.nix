{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.multimedia.spotify;
in
{
  options.modules.multimedia.spotify = {
    enable = mkEnableOption "Enable Spotify Desktop APp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
      playerctl
    ];
  };
}
