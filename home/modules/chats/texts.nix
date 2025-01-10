{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.chats.texts;

  appImage = pkgs.fetchurl {
    url = "https://texts.com/api/install/linux/x64/latest.AppImage";
    name = "texts.AppImage";
    # You'll need to update this hash when the AppImage is updated
    sha256 = "sha256-gKI0TXn/tTttOHgjHldfNcs3mPxzwKabAuAulR/bW88=";
  };

  wrappedAppImage = pkgs.writeShellScriptBin "texts" ''
    ${pkgs.appimage-run}/bin/appimage-run ${appImage} "$@"
  '';

in
{
  options.modules.chats.texts = {
    enable = mkEnableOption "Enable Texts Chat Application";
  };

  config = mkIf cfg.enable {
    home.packages = [
      wrappedAppImage
      pkgs.appimage-run
    ];

    # Create desktop entry
    xdg.desktopEntries.texts = {
      name = "Texts";
      exec = "${wrappedAppImage}/bin/texts";
      icon = "text-editor"; # You might want to customize this
      comment = "The central chatting application";
      categories = [
        "Chat"
      ];
      type = "Application";
    };

    # Make the AppImage executable
    home.file.".local/bin/texts".source = appImage;
    home.file.".local/bin/texts".onChange = ''
      chmod +x ~/.local/bin/texts
    '';
  };
}
