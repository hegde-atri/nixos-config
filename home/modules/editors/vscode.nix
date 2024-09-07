{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.vscode;
in
{
  options.modules.editors.vscode = {
    enable = mkEnableOption "Enable VSCode support";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        mkhl.direnv
        equinusocio.vsc-material-theme-icons
        dracula-theme.theme-dracula
        vscodevim.vim
        gruntfuggly.todo-tree

        github.copilot
        github.copilot-chat

        jnoortheen.nix-ide
        arrterian.nix-env-selector
        esbenp.prettier-vscode
        yoavbls.pretty-ts-errors
      ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = "eq-material-theme-icons-palenight";
        "workbench.colorTheme" = "Dracula Theme";
        "editor.formatOnSave" = true;

        "editor.semanticHighlighting.enabled" = true;
        "terminal.integrated.minimumContrastRatio" = 1;
        "window.titleBarStyle" = "custom";
        "editor.fontFamily" = "JetBrains Mono";
        "editor.minimap.enabled" = false;
        "todohighlight.keywords" = [
          {
            "text" = "TODO:";
            "color" = "#C678DD";
            "backgroundColor" = "transparent";
          }
          {
            "text" = "NOTE:";
            "color" = "#C678DD";
            "backgroundColor" = "transparent";
          }
          {
            "text" = "FIXME:";
            "color" = "#C678DD";
            "backgroundColor" = "transparent";
          }
        ];
      };
    };
  };
}
