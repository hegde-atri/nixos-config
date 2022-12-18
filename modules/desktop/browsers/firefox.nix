{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.firefox;
in {
  options.modules.desktop.browsers.firefox = with types; {
    enable = mkBookOpt false;
    profileName = mkOpt types.str config.user.name;

    settings
  }
}