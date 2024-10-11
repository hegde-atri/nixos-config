{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.editors.emacs;
in
{
  options.modules.editors.emacs = {
    enable = mkEnableOption "Enable Emacs support";
  };

  config = mkIf cfg.enable {
    # TODO clone doom in .config?
    services.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      defaultEditor = true;
      startWithUserSession = "graphical";
      client = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      emacs29-pgtk
      emacsPackages.vterm
      emacsPackages.python
      emacsPackages.emacsql
      emacsPackages.emacsql-sqlite
      emacsPackages.pdf-tools
      # requirements
      libtool
      ripgrep
      fd
      pandoc
      (texlive.combine { inherit (texlive) scheme-full minted; })
      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
        ]
      ))
      (python3.withPackages (ps: with ps; [ pygments ]))
      clang
      imagemagick
      zstd
      gnutls
      nixfmt-rfc-style
      nil
    ];
  };
}
