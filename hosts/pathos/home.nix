{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  imports = [
    ../../home/default.nix
  ];

  modules.chats.signal.enable = true;

  modules.desktop.hyprland.enable = true;

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
    shellAliases = {
      cd = "z";
    };
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
  services.mako = {
    enable = true;
  };
  # MPV
  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override { vapoursynthSupport = true; };
      youtubeSupport = true;
    };
    config = {
      profile = "gpu-hq";
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
  };

  home.pointerCursor = {
    name = "Capitaine Cursors";
    package = pkgs.capitaine-cursors;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "adw-gtk3-dark";
        color-scheme = "prefer-dark";
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    # theme = {
    #   name = "Adwaita-Dark";
    #   package = pkgs.gnome-themes-extra;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Activity Watch
  services.activitywatch = {
    enable = true;
    watchers = {
      aw-watcher-windows = {
        package = pkgs.activitywatch;
        settings = {
          poll_time = 2;
        };
      };
    };
  };

  # Gnome keyring
  services.gnome-keyring = {
    enable = true;
  };

  # GNU GPG
  programs.gpg = {
    enable = true;
  };

  # SSH
  programs.ssh = {
    enable = false;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        app-id = "foot";
        title = "foot";
        font = "JetBrainsMono Nerd Font:size=8";
        # dpi-aware = "yes";
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

  programs.direnv = {
    enable = true;
  };

  programs.fuzzel = {
    enable = true;
  };
  # Look into anyrun

  services.kanshi = {
    enable = true;
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
    ags
    slurp
    grim
    grimblast
    wl-clipboard
    nautilus
    gtk3
    pfetch
    yt-dlp
    _7zz
    joshuto
    anytype
    btop
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
    QT_QPA_PLATFORM        = "wayland";
    SDL_VIDEODRIVER        = "wayland";
    CLUTTER_BACKEND        = "wayland";
    GDK_BACKEND            = "wayland";
    MOZ_ENABLE_WAYLAND     = "1";
    XDG_SESSION_TYPE       = "wayland";
    NIXOS_OZONE_WL = "1";
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
