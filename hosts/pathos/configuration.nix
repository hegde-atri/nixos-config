# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
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

  networking.hostName = "pathos"; # Define your hostname.

  # TODO: Autoupgrade
  #

  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';

  modules.boot.enable = true;
  modules.environment.enable = true;
  modules.fonts.enable = true;

  modules.hardware.amd.cpu.enable = true;
  modules.hardware.amd.graphics.enable = true;

  modules.hardware.audio.enable = true;
  modules.hardware.bluetooth.enable = true;
  modules.hardware.battery.enable = true;
  modules.hardware.ssd.enable = true;

  modules.hyprland.enable = true;

  modules.locales.enable = true;
  modules.network.enable = true;
  modules.nix.enable = true;

  modules.programs.docker.enable = true;
  modules.programs.gnome-keyring.enable = true;
  modules.programs.gnupg.enable = true;
  modules.programs.zsh.enable = true;

  modules.security.enable = true;

  modules.services.auto-cpufreq.enable = true;
  modules.services.printing.enable = true;

  # modules = {
  #   locales.enable = true;
  #   network.enable = true;
  #   services = {
  #     printing.enable = true;
  #     auto-cpufreq.enable = true;
  #   };
  #   programs = {
  #     docker.enable = true;
  #     zsh.enable = true;
  #   };
  # };

  users.users.mizuuu = {
    isNormalUser = true;
    description = "Atri Hegde";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "kvm"
      "plugdev"
    ];
  };

  nix.settings.trusted-users = [
    "@wheel"
    "mizuuu"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "mizuuu" = import ./home.nix;
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
