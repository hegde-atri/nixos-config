{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop;
in {
  user.packages = with pkgs; [
    feh # image viewer
    libqalculate # calculator cli
    qgnomeplatform # QPlatformTheme for better Qt application inclusion in GNOME
    libsForQt5.qtstyleplugin-kvantum # SVG-based Qt5 theme engine plus config tool
  ];
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
      jetbrains-mono
    ];
  };

  # Try and get QT to respect GTK theme.
  env.GTK_DATA_PREFIX = [ "${config.system.path}" ];
  env.QT_QPA_PLATFORMTHEME = "gnome";
  env.QT_STYLE_OVERRIDE = "kvantum";

}
