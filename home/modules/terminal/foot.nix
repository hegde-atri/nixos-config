{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.terminal.foot;
in {
  options.modules.terminal.foot = {
    enable = mkEnableOption "Enable Foot Terminal";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          app-id = "foot";
          title = "foot";
          font = "JetBrainsMono Nerd Font:size=8";
          dpi-aware = "yes";
          pad = "10x10 center";
        };
        cursor = {
          style = "beam";
          blink = "yes";
        };
        colors = {
          alpha = "0.9";
          background = "14151b";
          foreground = "f8f8f2";
          regular0 = "21222c";
          regular1 = "ff5555";
          regular2 = "50fa7b";
          regular3 = "f1fa8c";
          regular4 = "bd93f9";
          regular5 = "ff79c6";
          regular6 = "8be9fd";
          regular7 = "f8f8f2";
          bright0 = "6272a4";
          bright1 = "ff6e6e";
          bright2 = "69ff94";
          bright3 = "ffffa5";
          bright4 = "d6acff";
          bright5 = "ff92df";
          bright6 = "a4ffff";
          bright7 = "ffffff";
          selection-foreground="ffffff";
          selection-background="44475a";
          urls = "8be9fd";
        };
      };
    };
  };
}