{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.zed;
in
{
  options.modules.editors.zed = {
    enable = mkEnableOption "Enable Zed support";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "org"
        "kotlin"
        "nix"

        "catppuccin"
        "kanagawa-themes"
        "tokyo-night"
      ];

      extraPackages = [
        pkgs.nixd
      ];

      userSettings = {
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Catppuccin Mocha";
        };
        features = {
          copilot = true;
        };
        vim_mode = true;
        relative_line_numbers = true;
        buffer_font_family = "JetBrainsMonoNL Nerd Font";
        # ui_font_size = 16;
        buffer_font_size = 14;
        autosave = {
          after_delay = {
            milliseconds = 500;
          };
        };
      };
    };
  };
}
