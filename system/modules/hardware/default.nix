{ ... }:

{
  imports = [
    ./amd/cpu.nix
    ./amd/graphics.nix
    ./audio.nix
    ./ssd.nix
    ./bluetooth.nix
    ./battery.nix
    ./fingerprint
  ];
}
