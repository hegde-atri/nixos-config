{ lib, config, ...}:
with lib;
let
  cfg = config.modules.terminal.cli-tools;
in {
  options = {
    modules.terminal.cli-tools = {
      enable = mkEnableOption "Enables CLI Tools";
      git-username = lib.mkOption {
        default = "hegde-atri";
        description = ''
          Your git username
        '';
      };
      git-email = lib.mkOption {
        default = "iamatrihegde@outlook.com";
        description = ''
          Your git email
        '';
      };
      git-sign = mkEnableOption "Sign commits with GPG";
      git-signingkey = lib.mkOption {
        default = "0DB99C10334E736E";
        description = ''
          Your GPG key Identifier
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # Basic ZSH
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting.enable = true;
    };

    # Git
    programs.git = {
      enable = true;
      userName = cfg.git-username;
      userEmail = cfg.git-email;
      delta = {
        enable = true;
      };
      extraConfig = {
        init.defaultBranch = "master";
      };
    } // (if cfg.git-sign then {
      signing = {
        signByDefault = true;
        key = cfg.git-signingkey;
      };
    } else {});

    # eza
    programs.eza = {
      enable = true;
      icons = true;
      enableZshIntegration = true;
    };

    # Starship
    programs.starship = {
      enable = true;
    };

    # Zoxide
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zsh.shellAliases = {
      cd = "z";
    };

    # Direnv + nix-direnv
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Editorconfig
    editorconfig.enable = true;

    # Ripgrep
    programs.ripgrep = {
      enable = true;
    };

    # GNU GPG
    programs.gpg = {
      enable = true;
    };
  };
}