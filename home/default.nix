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

    ./modules/misc/obsidian.nix
    ./modules/misc/ticktick.nix
  ];
}