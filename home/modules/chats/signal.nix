{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.chats.signal;

  signal-desktop = pkgs.callPackage (
    {
      stdenv,
      lib,
      fetchurl,
      autoPatchelfHook,
      dpkg,
      wrapGAppsHook3,
      makeWrapper,
      nixosTests,
      gtk3,
      atk,
      at-spi2-atk,
      cairo,
      pango,
      pipewire,
      gdk-pixbuf,
      glib,
      freetype,
      fontconfig,
      dbus,
      libX11,
      xorg,
      libXi,
      libXcursor,
      libXdamage,
      libXrandr,
      libXcomposite,
      libXext,
      libXfixes,
      libXrender,
      libXtst,
      libXScrnSaver,
      nss,
      nspr,
      alsa-lib,
      cups,
      expat,
      libuuid,
      at-spi2-core,
      libappindicator-gtk3,
      mesa,
      systemd,
      libnotify,
      libdbusmenu,
      libpulseaudio,
      xdg-utils,
      wayland,
    }:

    let
      pname = "signal-desktop";
      dir = "Signal";
      version = "7.30.0";
      url = "https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_${version}_amd64.deb";
      hash = "sha256-gpVebfjnHiZiQgjO29bhJ5JTK6KdA0vETY1jgeGuKXw=";

    in

    stdenv.mkDerivation rec {
      inherit pname version;

      src = fetchurl {
        inherit url hash;
      };

      nativeBuildInputs = [
        autoPatchelfHook
        dpkg
        (wrapGAppsHook3.override { inherit makeWrapper; })
      ];

      buildInputs = [
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        cairo
        cups
        dbus
        expat
        fontconfig
        freetype
        gdk-pixbuf
        glib
        gtk3
        libX11
        libXScrnSaver
        libXcomposite
        libXcursor
        libXdamage
        libXext
        libXfixes
        libXi
        libXrandr
        libXrender
        libXtst
        libappindicator-gtk3
        libnotify
        libuuid
        mesa
        nspr
        nss
        pango
        systemd
        xorg.libxcb
        xorg.libxshmfence
      ];

      runtimeDependencies = [
        (lib.getLib systemd)
        libappindicator-gtk3
        libnotify
        libdbusmenu
        pipewire
        stdenv.cc.cc
        xdg-utils
        wayland
      ];

      unpackPhase = "dpkg-deb -x $src .";

      dontBuild = true;
      dontConfigure = true;

      installPhase = ''
        runHook preInstall

        mkdir -p $out/lib

        mv usr/share $out/share
        mv "opt/${dir}" "$out/lib/${dir}"

        mkdir -p $out/bin
        ln -s "$out/lib/${dir}/${pname}" $out/bin/${pname}

        ln -s libGLESv2.so "$out/lib/${dir}/libGLESv2.so.2"

        runHook postInstall
      '';

      preFixup = ''
        gappsWrapperArgs+=(
          --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
          --suffix PATH : ${lib.makeBinPath [ xdg-utils ]}
        )

        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace "/opt/${dir}/${pname}" $out/bin/${pname} \
          --replace-fail "StartupWMClass=Signal" "StartupWMClass=signal"

        patchelf --add-needed ${libpulseaudio}/lib/libpulse.so "$out/lib/${dir}/resources/app.asar.unpacked/node_modules/@signalapp/ringrtc/build/linux/libringrtc-x64.node"
      '';

      meta = with lib; {
        description = "Private, simple, and secure messenger";
        homepage = "https://signal.org/";
        license = licenses.agpl3Only;
        maintainers = with maintainers; [
          eclairevoyant
          mic92
          equirosa
          urandom
          bkchr
          teutat3s
        ];
        platforms = [ "x86_64-linux" ];
        sourceProvenance = with sourceTypes; [ binaryNativeCode ];
      };
    }
  ) { };

in
{
  options.modules.chats.signal = {
    enable = mkEnableOption "Enable Signal Desktop App";
  };

  config = mkIf cfg.enable {
    home.packages = [ signal-desktop ];
  };
}
