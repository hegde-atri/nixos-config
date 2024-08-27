{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
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
  # Eza
  programs.eza = {
    enable = true;
    icons = true;
    enableZshIntegration = true;
  };


  # Activity Watch
  services.activitywatch = {
    enable = true;
  };

  # Gnome keyring
  services.gnome-keyring = {
    enable = true;
  };

  # GNU GPG
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  # SSH
  programs.ssh = {
    enable = false;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  programs.direnv = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,preferred,0x1080,1.0"
        "DP-1,1920x1080@144,0x0,1.0"
        "HDMI-A-1,preferred,0x0,1.0"
      ];
      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:eDP-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:eDP-1"
      ];
      "$mainMod" = "SUPER";
      cursor.inactive_timeout = 0;
      # Input Settings
      input = {
        kb_layout = "gb";
        numlock_by_default = true;
        follow_mouse = 2;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0.1;
        accel_profile = "flat";
      };
      # General Settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(938aa9ff) rgba(7aa89fff) 45deg";
        "col.inactive_border" = "rgba(1a1a1aff)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 2;
        blur = {
          enabled = true;
          size = 4;
          passes = 1;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 0;
      };
      animations = {
        enabled = true;
        bezier = [
          "linear,0,0,1,1"
          "overshot,0.05,0.9,0.1,1.1"
          "easeOut,0.25, 1, 0.5, 1"
        ];
        animation = [
          "windows,1,3,easeOut,slide"
          "workspaces,1,3,easeOut,slidefade"
          "fade,1,5,default"
        ];

      };
      windowrulev2 = [
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "float,class:^(firefox)$,title:^()$"
        "idleinhibit always, fullscreen:1"
      ];
      windowrule = [
        "opacity 1.0 0.8, foot"
      ];

      bind = [
        "$mainMod, return, exec, footclient"
        "$mainMod, U, exec, firefox"
        "$mainMod, Y, exec, emacsclient -nc"
        "$mainMod, O, exec, hyprlock"
        "$mainMod, P, exec, wlogout"
        "$mainMod, space, exec, pkill fuzzel || fuzzel"
        "$mainMod, W, exec, pkill set-bg || ~/.local/bin/custom/set-bg"
        "$mainMod, E, exec, pkill wofi-emoji || wofi-emoji"
        "$mainMod SHIFT, C, exec, hyprpicker -ar"
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, Q, exec, kill $(hyprctl activewindow | rg 'pid' | rg -oe '[0-9]+')"
        "$mainMod ALT, Q, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, X, pin"
        "$mainMod, F, fullscreen"
        "$mainMod SHIFT, F, fullscreenstate, 0, 2"
        "$mainMod, T, pseudo, # dwindle"
        "$mainMod, R, togglesplit, # dwindle"
        "$mainMod, G, togglegroup,"
        "ALT, TAB, changegroupactive, f"
        "ALT SHIFT, TAB, changegroupactive, b"
        "ALT SHIFT, P, exec, ~/.config/hypr/scripts/toggle_animations.sh"

        "SUPER_SHIFT,S,movetoworkspace,special"
        "SUPER,S,togglespecialworkspace"

        ",F1,pass,^(com\.obsproject\.Studio)$"
        ",F2,pass,^(com\.obsproject\.Studio)$"
        ",F3,pass,^(com\.obsproject\.Studio)$"
        ",F4,pass,^(com\.obsproject\.Studio)$"

# Move focus and move windows
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

# Resize window
        "$mainMod CTRL, h, resizeactive, -10 0"
        "$mainMod CTRL, l, resizeactive, 10 0"
        "$mainMod CTRL, k, resizeactive, 0 -10"
        "$mainMod CTRL, j, resizeactive, 0 10"

# Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

# Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

# Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

# windows workspace navigation like keymaps
        "$mainMod CTRL, right, workspace, e+1"
        "$mainMod CTRL, left, workspace, e-1"
        ",Print, exec, grimblast save area - | ~/.local/bin/custom/shadower | wl-copy"
        "$mainMod, Print, exec, grimblast save active - | ~/.local/bin/custom/shadower | wl-copy"
        "$mainMod SHIFT, Print, exec, grim -g '$(slurp)' - | swappy -f -"
      ];
    };
  };

  programs.kitty.enable = true;

  # Editorconfi and direnv

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    unzip
    cmake
    gnumake
    spotify
    pandoc
    texliveFull
    emacs
    emacsPackages.vterm
    emacsPackages.python
    emacsPackages.emacsql
    emacsPackages.emacsql-sqlite
    emacsPackages.pdf-tools
    kanshi
    telegram-desktop
    vesktop
    ripgrep
    ticktick
    signal-desktop
    protonvpn-gui
    protonmail-desktop
    fd
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mizuuu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
