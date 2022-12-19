{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mizuuu";
  home.homeDirectory = "/home/mizuuu";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
      firefox
      logseq obsidian
      pfetch neofetch
      gtk2
      alacritty trashy
      btop libsForQt5.gwenview
      discord spotify obs-studio
      mpv mpc-cli exa yt-dlp mpd playerctl
      rustup rust-analyzer go gopls ruby_3_1
      nodejs yarn python311
      git gcc _7zz neovim neovide ripgrep fd tmux vscode
      jetbrains.rider jetbrains.webstorm jetbrains.idea-ultimate
      wofi waybar eww-wayland slurp wl-clipboard swaylock swayidle
      xdg-desktop-portal xdg-desktop-portal-gtk grim sway-contrib.grimshot
      libnotify mako brightnessctl hyprpaper
      jetbrains-mono nerdfonts
  ];
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
