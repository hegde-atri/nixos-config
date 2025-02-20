{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.hardware.audio;
in
{
  options.modules.hardware.audio = {
    enable = mkEnableOption "Enable Audio using Pipewire.";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };
  };
}
