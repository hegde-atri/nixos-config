{ config, pkgs, ... }:

{
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

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
