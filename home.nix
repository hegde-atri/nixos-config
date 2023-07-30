{ config, pkgs, ... }:

{
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    pfetch
    btop
    discord
    sqlite
    starship
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
    brightnessctl
    nerdfonts
    jetbrains-mono
  ];

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
