{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./zsh.nix
    ./docker.nix
    ./gnupg.nix
    ./gnome-keyring.nix
  ];
}
