{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.dev.web;
in
{
  options.modules.dev.web = {
    enable = mkEnableOption "Enable Website Development";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      pnpm
      typescript
      typescript-language-server
      prettierd
    ];
  };
}
