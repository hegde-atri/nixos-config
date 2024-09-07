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
  ];
}
