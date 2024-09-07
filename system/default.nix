{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/services
    ./modules/hardware
    ./modules/programs
    ./modules/fonts
  ];
}
