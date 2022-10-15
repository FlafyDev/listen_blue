{ flutter
, lib
, llvmPackages_13
, cmake
, ninja
, pkg-config
, wrapGAppsHook
, autoPatchelfHook
, util-linux
, libselinux
, libsepol
, libthai
, libdatrie
, libxkbcommon
, at-spi2-core
, libsecret
, jsoncpp
, xorg
, dbus
, gtk3
, glib
, pcre
, libepoxy
, stdenvNoCC
, cacert
, git
, dart
, nukeReferences
, targetPlatform
, bash
, curl
, unzip
, which
, xz
, yamlLib
, stdenv
, fetchzip
, makeWrapper
, runCommand
, clang
, atk
, cairo
, epoxy
, gdk-pixbuf
, pango
, harfbuzz
, gnugrep
, gst_all_1
, libunwind
, elfutils
, zstd
, orc
}:

{ pname
, version
, specFile
, lockFile
, dartFlags ? [ ]
, buildDir ? "build"
, buildType ? "release"
, src ? null
, srcs ? null
, ...
}@args:

let
  inherit (builtins)
    mapAttrs
    foldl'
    attrValues
    ;

  inherit (lib)
    importJSON
    concatStringsSep
    removePrefix
    filter
    mapAttrsToList
    concatStrings
    makeLibraryPath
    makeSearchPath
    ;

  # exportEnvVar = key: value: ''
  #   export ${key}="${value}"
  # '';
  #
  # exportEnvVars = envVars:
  #   concatStrings (mapAttrsToList exportEnvVar envVars);

  createCacheStamp = { name, from ? name }: ''
    ln -s \
      "${flutter.unwrapped}/bin/internal/${from}.version" \
      "${name}.stamp"
  '';

  specFile' = yamlLib.readYAML specFile;
  lockFile' = yamlLib.readYAML lockFile;

  pubCache =
    let
      step = (state: package:
        let
          pubCachePathParent = concatStringsSep "/" [
            "$out"
            package.source
            (removePrefix "https://" package.description.url)
          ];
          pubCachePath = concatStringsSep "/" [
            pubCachePathParent
            "${package.description.name}-${package.version}"
          ];
          nixStorePath = fetchzip {
            inherit (package) sha256;
            stripRoot = false;
            url = concatStringsSep "/" [
              package.description.url
              "packages"
              package.description.name
              "versions"
              "${package.version}.tar.gz"
            ];
          };
        in
        state + ''
          mkdir -p ${pubCachePathParent}
          ln -s ${nixStorePath} ${pubCachePath}
        ''
      );

      synthesize =
        foldl' step "" (filter (pkg: pkg.source == "hosted") (attrValues lockFile'.packages));
    in
    runCommand "${pname}-pub-cache" { } synthesize;
  sdkDeps = mapAttrs (_: fetchzip) (importJSON ../sdkdeps2nix.lock);
in
stdenv.mkDerivation (rec {
  # nativeBuildInputs = (args.nativeBuildInputs or [ ]) ++ [
  #   makeWrapper
  #   cmake
  #   dart
  #   at-spi2-core.dev
  #   clang
  #   cmake
  #   dart
  #   dbus.dev
  #   flutter
  #   gtk3
  #   libdatrie
  #   libepoxy.dev
  #   libselinux
  #   libsepol
  #   libthai
  #   libxkbcommon
  #   ninja
  #   pcre
  #   pkg-config
  #   util-linux.dev
  #   xorg.libXdmcp
  #   xorg.libXtst
  #   gst_all_1.gstreamer
  #   gst_all_1.gst-libav
  #   gst_all_1.gst-plugins-base
  #   gst_all_1.gst-plugins-good
  #   libunwind
  #   elfutils
  #   zstd
  #   orc
  # ];
  #
  # buildInputs = (args.buildInputs or [ ]) ++ [
  #   gtk3
  #   glib
  #   pcre
  #   util-linux
  #   # also required by cmake, not sure if really needed or dep of all packages
  #   libselinux
  #   libsepol
  #   libthai
  #   libdatrie
  #   xorg.libXdmcp
  #   xorg.libXtst
  #   libxkbcommon
  #   dbus
  #   at-spi2-core
  #   libsecret
  #   jsoncpp
  #   # build deps
  #   xorg.libX11
  #   # directly required by build
  #   libepoxy
  #   wrapGAppsHook
  # ];
  nativeBuildInputs = [
   # flutter dev tools
    cmake
    ninja
    pkg-config
    wrapGAppsHook
    # flutter likes dynamic linking
    autoPatchelfHook
    # flutter deps
    # flutter.unwrapped
    bash
    curl
    flutter.dart
    git
    unzip
    which
    xz
  ];
  buildInputs = [
    # flutter.unwrapped
    at-spi2-core.dev
    clang
    cmake
    dart
    dbus.dev
    flutter
    gtk3
    libdatrie
    libepoxy.dev
    libselinux
    libsepol
    libthai
    libxkbcommon
    ninja
    pcre
    pkg-config
    util-linux.dev
    xorg.libXdmcp
    xorg.libXtst
    gtk3
    glib
    pcre
    util-linux

    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    libunwind
    elfutils
    zstd
    orc
    # also required by cmake, not sure if really needed or dep of all packages
    # libselinux
    # libsepol
    # libthai
    # libdatrie
    # xorg.libXdmcp
    # xorg.libXtst
    # libxkbcommon
    # dbus
    # at-spi2-core
    # libsecret
    # jsoncpp
    # # build deps
    # xorg.libX11
    # # directly required by build
    # libepoxy
  ];

  PUB_CACHE = toString pubCache;
  NIX_LDFLAGS = "-rpath ${lib.makeLibraryPath [
    # cmake deps
    gtk3
    glib
    pcre
    util-linux
    # also required by cmake, not sure if really needed or dep of all packages
    libselinux
    libsepol
    libthai
    libdatrie
    xorg.libXdmcp
    xorg.libXtst
    libxkbcommon
    dbus
    at-spi2-core
    libsecret
    jsoncpp
    # build deps
    xorg.libX11
    # directly required by build
    libepoxy
  ]}";
  # NIX_CFLAGS_COMPILE = "-I${xorg.libX11}/include";
  # LD_LIBRARY_PATH = lib.makeLibraryPath [
  #   # build deps
  #   xorg.libX11
  #   # directly required by build
  #   libepoxy
  # ];

  # CPATH = with xorg; makeSearchPath "include" [
  #   libX11.dev # X11/Xlib.h
  #   xorgproto # X11/X.h
  #   cairo.dev
  #   gst_all_1.gstreamer.dev
  #   gst_all_1.gstreamer
  # ];
  LD_LIBRARY_PATH="${libepoxy}/lib";
  # LD_LIBRARY_PATH = makeLibraryPath [
  #   # cmake deps
  #   gtk3
  #   glib
  #   pcre
  #   util-linux
  #   # also required by cmake, not sure if really needed or dep of all packages
  #   libselinux
  #   libsepol
  #   libthai
  #   libdatrie
  #   xorg.libXdmcp
  #   xorg.libXtst
  #   libxkbcommon
  #   dbus
  #   at-spi2-core
  #   libsecret
  #   jsoncpp
  #   # build deps
  #   xorg.libX11
  #   # directly required by build
  #   libepoxy
  # ];

  # outputHash = lib.fakeSha256;
  # outputHashAlgo = "sha256";

  dontUseCmakeConfigure = true;

  configurePhase = with sdkDeps; ''
    runHook preConfigure

    HOME=$(mktemp -d)

    mkdir -p "$HOME"/.cache/flutter/{artifacts,pkg}
    mkdir -p "$HOME"/.cache/flutter/artifacts/engine/{common,linux-x64}
    
    pushd "$HOME/.cache/flutter"
    
    ln -s ${material-fonts} artifacts/material_fonts
    
    ln -s ${gradle-wrapper} artifacts/gradle_wrapper
    
    ln -s ${sky-engine} pkg/sky_engine
    ln -s ${flutter-patched-sdk} artifacts/engine/common/flutter_patched_sdk
    ln -s ${flutter-patched-sdk-product} artifacts/engine/common/flutter_patched_sdk_product
    ln -s ${linux-x64-artifacts}/* artifacts/engine/linux-x64
    
    ln -s ${linux-x64-font-subset}/* artifacts/engine/linux-x64
    
    ln -s ${linux-x64-linux-x64-flutter-gtk}/* artifacts/engine/linux-x64
    ln -s ${linux-x64-profile-linux-x64-flutter-gtk} artifacts/engine/linux-x64-profile
    ln -s ${linux-x64-release-linux-x64-flutter-gtk} artifacts/engine/linux-x64-release
    
    ${createCacheStamp { name = "flutter_sdk"; from = "engine"; }}
    ${createCacheStamp { name = "font-subset"; from = "engine"; }}
    ${createCacheStamp { name = "gradle_wrapper"; }}
    ${createCacheStamp { name = "material_fonts"; }}
    
    ${createCacheStamp { name = "linux-sdk"; from = "engine"; }}

    popd

    flutter config --no-analytics &>/dev/null # mute first-run
    flutter config --enable-linux-desktop
    export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

    flutter pub get --offline

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    flutter build linux -v || true

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    built=build/linux/*/release/bundle

    mkdir -p $out/bin
    mv $built $out/app

    for f in $(find $out/app -iname "*.desktop" -type f); do
      install -D $f $out/share/applications/$(basename $f)
    done

    for f in $(find $out/app -maxdepth 1 -type f); do
      ln -s $f $out/bin/$(basename $f)
    done

    # this confuses autopatchelf hook otherwise
    rm -rf "$HOME"

    # make *.so executable
    find $out/app -iname "*.so" -type f -exec chmod +x {} +

    # remove stuff like /build/source/packages/ubuntu_desktop_installer/linux/flutter/ephemeral
    for f in $(find $out/app -executable -type f); do
      if patchelf --print-rpath "$f" | grep /build; then # this ignores static libs (e,g. libapp.so) also
        echo "strip RPath of $f"
        newrp=$(patchelf --print-rpath $f | sed -r "s|/build.*ephemeral:||g" | sed -r "s|/build.*profile:||g")
        patchelf --set-rpath "$newrp" "$f"
      fi
    done

    runHook postInstall
  '';
}
//
(removeAttrs args [
  "nativeBuildInputs"
  "buildInputs"
  "buildPhase"
  "installPhase"
  "passthru"
  "meta"
]))

 # shellHook =
    #   ''
    #     flutter config \
    #       --enable-linux-desktop \
    #       > /dev/null
    #   ''
    #   + exportEnvVars (
    #     let
    #       bb = [
    #         atk.out
    #         cairo.out
    #         epoxy.out
    #         gdk-pixbuf.out
    #         glib.out
    #         gtk3.out
    #         pango.out
    #         cairo
    #         harfbuzz.out
    #         # cmake deps
    #         gtk3
    #         glib
    #         pcre
    #         util-linux
    #         # also required by cmake, not sure if really needed or dep of all packages
    #         libselinux
    #         libthai
    #         libdatrie
    #         xorg.libXdmcp
    #         xorg.libXtst
    #         libxkbcommon
    #         dbus
    #         at-spi2-core
    #         libsecret
    #         jsoncpp
    #         # build deps
    #         xorg.libX11
    #         # directly required by build
    #         libepoxy
    #       ];
    #     in
    #     {
    #       CPATH = with xorg; makeSearchPath "include" [
    #         libX11.dev # X11/Xlib.h
    #         xorgproto # X11/X.h
    #         cairo
    #         cairo.out
    #       ];
    #       NIX_LDFLAGS = "-rpath ${lib.makeLibraryPath bb}";
    #       NIX_CFLAGS_COMPILE = "-I${xorg.libX11}/include";
    #
    #       LD_LIBRARY_PATH = makeLibraryPath bb;
    #     }
    #   );


  # ${createCacheStamp { name = "flutter_sdk"; from = "engine"; }}
  # ${createCacheStamp { name = "font-subset"; from = "engine"; }}
  # ${createCacheStamp { name = "gradle_wrapper"; }}
  # ${createCacheStamp { name = "material_fonts"; }}
  #
  # ${createCacheStamp { name = "linux-sdk"; from = "engine"; }}
