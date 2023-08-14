# Setup and enforce XDG compliance.

{ config, home-manager, ... }:

{
  home-manager.users.${config.user.name}.xdg.enable = true;

  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
    variables = {
      __GL_SHADER_DISK_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    };
  };
}
