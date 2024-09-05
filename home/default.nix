{ config, pkgs, inputs, ...}:

{
  imports = [
    ./modules/browsers/chromium.nix
    ./modules/browsers/firefox.nix

    ./modules/chats/signal.nix
    ./modules/chats/discord.nix
    ./modules/chats/telegram.nix

    ./modules/desktop/hyprland.nix

    ./modules/editors/emacs.nix
    ./modules/editors/vscode.nix

    ./modules/terminal/cli-tools.nix
    ./modules/terminal/foot.nix

    ./modules/multimedia/mpv.nix
    ./modules/multimedia/spotify.nix

    ./modules/misc/anytype.nix
    ./modules/misc/syncthing.nix
    ./modules/misc/obsidian.nix
    ./modules/misc/ticktick.nix
  ];
}