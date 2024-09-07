{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.modules.fonts;

  appleColorEmoji = pkgs.fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/latest/download/AppleColorEmoji.ttf";
    sha256 = "sha256-SG3JQLybhY/fMX+XqmB/BKhQSBB0N1VRqa+H6laVUPE=";
  };
  iosevkaAile = pkgs.fetchzip {
    url = "https://github.com/be5invis/Iosevka/releases/download/v31.6.0/PkgTTC-IosevkaAile-31.6.0.zip";
    sha256 = "sha256-nHDisG2njkb2+XX7UUCUQVbVCPUQW3zdgwmPqR5wYK4=";
    stripRoot = false;
  };
in
{
  options.modules.fonts = {
    enable = mkEnableOption "Enable Preferred Fonts";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      liberation_ttf
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      # Emoji
      (stdenv.mkDerivation {
        name = "apple-color-emoji";
        src = appleColorEmoji;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
        '';
      })
      # Ioveska Aile
      (stdenv.mkDerivation {
        name = "iosevka-aile";
        src = iosevkaAile;
        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp *.ttc $out/share/fonts/truetype/
        '';
      })
    ];
    fonts.fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
