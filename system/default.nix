{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/boot
    ./modules/environment
    ./modules/fonts
    ./modules/hardware
    ./modules/hyprland
    ./modules/locales
    ./modules/network
    ./modules/nix
    ./modules/plasma
    ./modules/programs
    ./modules/security
    ./modules/services
  ];
}
