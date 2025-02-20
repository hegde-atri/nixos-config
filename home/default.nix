{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/browsers/chromium.nix
    ./modules/browsers/firefox.nix
    ./modules/browsers/zen.nix

    ./modules/chats/signal.nix
    ./modules/chats/discord.nix
    ./modules/chats/telegram.nix
    ./modules/chats/texts.nix

    ./modules/desktop/hyprland.nix

    ./modules/dev/go.nix
    ./modules/dev/python.nix
    ./modules/dev/rust.nix
    ./modules/dev/web.nix

    ./modules/services/syncthing.nix

    ./modules/editors/emacs.nix
    ./modules/editors/intellij.nix
    ./modules/editors/vscode.nix
    ./modules/editors/android-studio.nix
    ./modules/editors/zed.nix

    ./modules/terminal/cli-tools.nix
    ./modules/terminal/foot.nix
    ./modules/terminal/kitty.nix

    ./modules/multimedia/mpv.nix
    ./modules/multimedia/spotify.nix

    ./modules/proton/vpn.nix
    ./modules/proton/pass.nix
    ./modules/proton/mail.nix

    ./modules/misc/anytype.nix
    ./modules/misc/gammastep.nix
    ./modules/misc/obsidian.nix
    ./modules/misc/openfortivpn.nix
    ./modules/misc/remnote.nix
    ./modules/misc/syncthing.nix
    ./modules/misc/ticktick.nix
    ./modules/misc/tradingview.nix
  ];
}
