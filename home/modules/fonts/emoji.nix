{
  config,
  pkgs,
  lib,
  ...
}:

let
  appleColorEmoji = pkgs.fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/latest/download/AppleColorEmoji.ttf";
    sha256 = ""; # You'll need to add the correct hash here
  };
in
{
  fonts.fonts = with pkgs; [
    (stdenv.mkDerivation {
      name = "apple-color-emoji";
      src = appleColorEmoji;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
      '';
    })
  ];
}
