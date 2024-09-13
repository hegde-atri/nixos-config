{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.services.auto-cpufreq;
in
{
  options.modules.services.auto-cpufreq = {
    enable = mkEnableOption "Enable auto-cpufreq";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = false;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
          scaling_min_freq = 400000;
          scaling_max_freq = 2400000;
          energy_performance_preference = "power";
        };
      };
    };
  };
}
