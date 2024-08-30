{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.editors.vscode;
in {
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
        alvarosannas.nix
        vscodevim.vim
        alvarosannas.nix

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
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Thanatos";
        "editor.formatOnSave" = true;
      };
    };
  };
}
