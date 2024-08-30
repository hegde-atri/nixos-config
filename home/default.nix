{ config, pkgs, inputs, ...}:

{
  imports = [
    ./modules/chats/signal.nix
    ./modules/desktop/hyprland.nix
  ]
}