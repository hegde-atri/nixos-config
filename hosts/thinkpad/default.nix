# My Thinkpad E14

{ ... }:
{
  imports = [
    ../home.nix
    ./hardware-configuration.nix
  ]

  # Modules
  modules = {
    desktop = {
      hyprland.enable = true;
      apps = {
        wofi.enable = true;
      };
      browsers = {
        firefox.enable = true;
      };
      gaming = {
        steam.enable = true;
      };
      media = {
        mpv.enable = true;
        mpd.enable = true;
        spotify.enable = true;
      };
      term = {
        alacritty.enable = true;
      };
      vm = {
        qemu.enable = true;
      };
    };
    dev = {
      node.enable = true;
      rust.enable = true;
      python.enable = true;
    };
    editors = {
      default = "nvim";
      emacs.enable = true;
      vim.enable = true;
    };
    shell = {
      git.enable = true;
      gnupg.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
    services = {
      # ssh.enable = true;
      docker.enable = true;
    };
    theme.active = "alucard";
  };

  # Local config
  time.timeZone = "Europe/London";
}