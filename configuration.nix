# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-a419e6e4-3d3b-45fa-9494-48a1563d1430".device = "/dev/disk/by-uuid/a419e6e4-3d3b-45fa-9494-48a1563d1430";
  boot.initrd.luks.devices."luks-a419e6e4-3d3b-45fa-9494-48a1563d1430".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "alpha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.wlr.settings = {
    screencast = {
      output_name = "HDMI-A-1";
      max_fps = 30;
      # exec_before = "disable_notifications.sh";
      # exec_after = "enable_notifications.sh";
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mizuuu = {
    isNormalUser = true;
    description = "Atri Hegde";
    extraGroups = [ "networkmanager" "wheel" "input" "mpd"];
    packages = with pkgs; [];
  };

  services.emacs.enable = true;
  services.emacs.defaultEditor = false;
  services.emacs.package = pkgs.emacs-gtk;


  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    shellAliases = { };
  };

  services.mpd = {
    enable = true;
    user = "mizuuu";
    group = "users";
    dataDir = "/home/mizuuu/Music/mpd";
    dbFile = "/home/mizuuu/Music/mpd/tag_cache";
    musicDirectory = "/home/mizuuu/Music/mpd/music";
    extraConfig = ''
    auto_update "yes"
      audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }
      audio_output {
        type    "fifo"
        name    "my_fifo"
        path    "/tmp/mpd.fifo"
        format  "44100:16:2"
    }
    '';
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match user
  };

  # Session variables
  environment.variables = rec {
    EDITOR = "nvim";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # fprintd
  services.fprintd.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget ncmpcpp
    emacs-gtk
  ];
  services.auto-cpufreq.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # optimise store
  nix.settings.auto-optimise-store = true;
  # garbage collect packages
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  nix.settings.substituters = ["https://hyprland.cachix.org"];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];


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
  system.stateVersion = "22.11"; # Did you read the comment?

  # Overlay for updating discord
  nixpkgs.overlays = [
  	(self: super: {
		discord = super.discord.overrideAttrs (
			_: { src = builtins.fetchTarball {
				url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "1z980p3zmwmy29cdz2v8c36ywrybr7saw8n0w7wlb74m63zb9gpi";
				}; }
			);
		})
	];


  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    };
}
