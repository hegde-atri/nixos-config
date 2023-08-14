{config, pkgs, ...}:
{
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland,x11";
      _JAVA_AWT_WM_NONREPARENTING = 1;
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
      # only needed for Sway
      XDG_CURRENT_DESKTOP = "sway";
    };
  };

  home.packages = with pkgs; [
    firefox
    pfetch
    carapace
    btop
    discord
    sqlite
    glib
    neofetch
    android-studio
    cmake
    ledger
    libgccjit
    llvmPackages_rocm.clang
    yt-dlp
    alsa-utils
    obs-studio
    wl-clipboard
    wayland-protocols
    gotests
    git
    _7zz
    neovim
    ripgrep
    fd
    brightnessctl
    nushell
    gnumake
    # (ncmpcpp.override { visualizerSupport = true; })
    mpc-cli
    playerctl
    ## Dev languages
    # Golang
    go
    gopls
    gore
    gotools
    # Rust
    rustup
    # Node
    nodejs_20
    # Python
    python3
    joshuto
    # Fonts
  ];

  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.foot = {
    enable = true;
    package = pkgs.foot;
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

  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.exa = {
    enable = true;
    package = pkgs.exa;
    enableAliases = true;
    icons = true;
  };

programs.mpv = {
  enable = true;
  package = pkgs.wrapMpv (pkgs.mpv-unwrapped.override { vapoursynthSupport = true; }) { youtubeSupport = true; };
  config = {
    profile = "gpu-hq";
    force-window = true;
    ytdl-format = "bestvideo+bestaudio";
    cache-default = 4000000;
  };
};

  services.mpd = {
    enable = true;
    package = pkgs.mpd;
    extraConfig = ''
      db_file "~/Music/tag_cache"
      log_file "syslog"
      music_directory "~/Music/music"
      playlist_directory "~/Music/playlists"
      pid_file "~/Music/pid"
      state_file "~/Music/state"
      sticker_file "~/Music/sticker.sql"

      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }

      audio_output {
        type                    "fifo"
        name                    "my_fifo"
        path                    "/tmp/mpd.fifo"
        format                  "44100:16:2"
      }
      '';
    # dataDir = "~/Music";
    # dbFile = "~/Music/tag_cache";
    musicDirectory = "~/Music/music";
    # playlistDirectory = "~/Music/playlists";
  };

  services.mpd-discord-rpc = {
    enable = true;
    package = pkgs.mpd-discord-rpc;
    settings = {
      id = 677226551607033903;
      hosts = ["localhost:6600"];
      format = {
        details = "$title";
        state = "$artist / $album";
      };
    };
  };

  programs.ncmpcpp = {
    enable = true;
    package = (pkgs.ncmpcpp.override {visualizerSupport = true;});
    mpdMusicDir = "~/Music/music";
  };

  home.pointerCursor = {
    name = "Capitaine Cursors";
    package = pkgs.capitaine-cursors;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
    };
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
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

}
