{ lib, config, ...}:
with lib;
let
  cfg = config.modules.terminal.cli-tools;
in {
  options = {
    modules.terminal.cli-tools.enable = mkEnableOption "Enables CLI Tools";
  };

  config = mkIf cfg.enable {
    # eza
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };

    # ripgrep
    programs.ripgrep = {
      enable = true;
    };

    programs.zsh.shellAliases = ""
    "";
  }
}