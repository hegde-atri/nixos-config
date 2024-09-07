{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/programs/docker.nix
    ./modules/programs/zsh.nix

    ./modules/fonts
  ];
}
