{ config, pkgs, ... }:

{
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

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

  # home.shellAliases
  # home.sessionPath
  # wayland.windowManager.hyprland.enable
  # programs.direnv.enableNushellIntegration

  home.packages = with pkgs; [
    firefox
    pfetch
    carapace
    btop
    discord
    sqlite
    starship
    neofetch
    android-studio
    cmake
    ledger
    libgccjit
    llvmPackages_rocm.clang
    yt-dlp
    alsa-utils
    obs-studio
    go
    gopls
    gore
    gotools
    wl-clipboard
    wayland-protocols
    gotests
    zoxide
    foot
    rustup
    mpv
    nodejs_20
    git
    _7zz
    neovim
    ripgrep
    fd
    mpd
    brightnessctl
    gnumake
    (ncmpcpp.override { visualizerSupport = true; })
    mpc-cli
    playerctl
    python3
  ];
  programs.nushell.enable = true;

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
