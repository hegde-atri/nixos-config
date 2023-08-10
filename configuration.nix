{ config, lib, pkgs, ... }:
{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pathos";

  networking.networkmanager.enable = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    overpass
    iosevka
    nerdfonts
    jetbrains-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    libtool
    vim
    virt-manager
    direnv
    wget
    nushell
    pfetch
    neovim
    emacs
    firefox
    spotify
    git
    exa
    waybar
    libnotify
    mako
    swww
    kitty
    foot
    wofi
    eww
    pinentry
    # idk why but here we are
    liberation_ttf
  ];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };
    battery = {
      governor = "powersave";
      turbo = "auto";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  users.users.mizuuu = {
    isNormalUser = true;
    home = "/home/mizuuu";
    initialPassword = "password";
    extraGroups = [ "wheel" "libvirtd" ];
    shell = pkgs.nushell;
  };
  # support opengl 32-bit
  hardware.opengl.driSupport32Bit = true;

  programs.steam.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  services.printing.enable = true;

  virtualisation.libvirtd.enable = true;

  environment.binsh = "${pkgs.dash}/bin/dash";

  services.openssh.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  system.stateVersion = "23.11";
}
