{
  description = "A Music Player written in Flutter for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    dart-flutter.url = "github:flafydev/dart-flutter-nix";
  };

  outputs = { self, flake-utils, nixpkgs, dart-flutter }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ dart-flutter.overlays.default ];
          };
        in
        {
          packages = rec {
            listen-blue = pkgs.callPackage ./nix/package.nix { };
            default = listen-blue;
          };
          devShell = pkgs.mkShell {
            packages = [
              pkgs.deps2nix
            ];
            buildInputs = with pkgs; [
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
              gst_all_1.gstreamer
              gst_all_1.gst-libav
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
              libunwind
              elfutils
              zstd
              orc
            ];
            shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.libepoxy}/lib
            '';
          };
        }) // {
      overlays.default = final: prev:
        let
          pkgs = import nixpkgs {
            inherit (prev) system;
            overlays = [ dart-flutter.overlays.default ];
          };
        in
        {
          listen-blue = pkgs.callPackage ./nix/package.nix { };
        };
    };
}

