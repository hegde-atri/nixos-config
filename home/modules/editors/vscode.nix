{ config
, lib
, ...
}:

with lib;

let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "Enable Emacs support";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = true;
      package = pkgs.vscode;
      extensions = with vscode-extensions; [
        mkhl.direnv
        equinusocio.vsc-material-theme-icons
        vscodevim.vim

        github.copilot
        github.copilot-chat

        jnoortheen.nix-ide
        arrterian.nix-env-selector
        esbenp.prettier-vscode
        yoavbls.pretty-ts-errors
      ];
      userSettings = {
        "files.autosave" = "afterDelay";
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.formatOnSave" = true;
      };
    };
  };
}