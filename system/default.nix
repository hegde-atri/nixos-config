{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/boot
    ./modules/fonts
    ./modules/services
    ./modules/hardware
    ./modules/programs
    ./modules/hyprland
    ./modules/plasma
    ./modules/locales
    ./modules/network
  ];
}
