# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../system
    inputs.home-manager.nixosModules.default
  ];

  networking.hostName = "opal"; # Define your hostname.

  # TODO: Autoupgrade
  modules.boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "acpi_backlight=native"
    "amd_pstate=guided"
    "amdgpu"
  ];
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    # AMD ROCm OpenCL runtime
    rocmPackages.clr
    rocmPackages.clr.icd

    # AMDVLK drivers can be used in addition to the Mesa RADV drivers.
    #amdvlk
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };
  # Most software has the HIP libraries hard-coded. Workaround:
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  modules.environment.enable = true;
  modules.fonts.enable = true;

  # modules.hardware.amd.cpu.enable = true;
  modules.hardware.amd.graphics.enable = true;

  modules.hardware.audio.enable = true;
  modules.hardware.bluetooth.enable = true;
  modules.hardware.battery.enable = true;
  modules.hardware.fingerprint.enable = true;
  modules.hardware.ssd.enable = true;

  modules.hyprland.enable = true;

  modules.locales.enable = true;
  modules.network.enable = true;
  modules.nix.enable = true;
  modules.nix.flake = "/home/aknee/repos/nixos-config";

  modules.programs.docker.enable = true;
  modules.programs.gnome-keyring.enable = true;
  modules.programs.gnupg.enable = true;
  modules.programs.zsh.enable = true;

  modules.security.enable = true;

  # modules.services.auto-cpufreq.enable = true;
  modules.services.tlp.enable = true;
  modules.services.printing.enable = true;

  users.users.aknee = {
    isNormalUser = true;
    description = "Annie Tse";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "kvm"
    ];
  };

  nix.settings.trusted-users = [
    "@wheel"
    "aknee"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "aknee" = import ./home.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
