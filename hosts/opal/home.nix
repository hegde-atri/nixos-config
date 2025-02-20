{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aknee";
  home.homeDirectory = "/home/aknee";

  imports = [ ../../home/default.nix ];

  modules = {
    browsers = {
      chromium.enable = true;
      firefox.enable = true;
      zen.enable = true;
    };
    chats = {
      signal.enable = true;
      discord.enable = true;
      texts.enable = true;
    };
    dev = {
      web.enable = true;
    };
    desktop = {
      hyprland.enable = true;
    };
    editors = {
      emacs.enable = true;
      vscode.enable = true;
      # android-studio.enable = true;
      zed.enable = true;
      intellij.enable = true;
    };
    terminal = {
      cli-tools = {
        enable = true;
        git-username = "annietse";
        git-email = "annietse03@gmail.com";
        git-sign = true;
        git-signingkey = "0x37ACCC3DDF60F43A";
      };
      foot.enable = true;
    };
    multimedia = {
      mpv.enable = true;
      spotify.enable = true;
    };
    proton = {
      mail.enable = true;
      vpn.enable = true;
      pass.enable = true;
    };
    misc = {
      anytype.enable = true;
      gammastep.enable = true;
      openfortivpn.enable = true;
      remnote.enable = true;
      syncthing.enable = true;
      ticktick.enable = true;
    };
  };

  # Look into anyrun
  # Look into kanshi
  # services.kanshi = {
  #   enable = true;
  # };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    pavucontrol
    nautilus
    gtk3
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mizuuu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
