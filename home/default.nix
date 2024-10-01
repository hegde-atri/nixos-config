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

    ./modules/chats/signal.nix
    ./modules/chats/discord.nix
    ./modules/chats/telegram.nix

    ./modules/desktop/hyprland.nix

    ./modules/dev/go.nix
    ./modules/dev/python.nix
    ./modules/dev/rust.nix

    ./modules/editors/emacs.nix
    ./modules/editors/vscode.nix
    ./modules/editors/android-studio.nix

    ./modules/terminal/cli-tools.nix
    ./modules/terminal/foot.nix

    ./modules/multimedia/mpv.nix
    ./modules/multimedia/spotify.nix

    ./modules/proton/vpn.nix
    ./modules/proton/pass.nix
    ./modules/proton/mail.nix

    ./modules/misc/anytype.nix
    ./modules/misc/notion.nix
    ./modules/misc/obsidian.nix
    ./modules/misc/openfortivpn.nix
    ./modules/misc/remnote.nix
    ./modules/misc/syncthing.nix
    ./modules/misc/ticktick.nix
    ./modules/misc/tradingview.nix
  ];
}
