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
    iosevka
    overpass
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
    nerdfonts
    gnumake
    (ncmpcpp.override { visualizerSupport = true; })
    mpc-cli
    jetbrains-mono
  ];
  programs.nushell.enable = true;
  fonts.fontconfig.enable = true;

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
  };

}
