{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.multimedia.mpv;
in {
  options.modules.multimedia.mpv = {
    enable = mkEnableOption "Enable MPV";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.yt-dlp ];

    programs.mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped.wrapper {
        mpv = pkgs.mpv-unwrapped.override { vapoursynthSupport = true; };
        youtubeSupport = true;
      };
      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}