{
  description = "A Music Player written in Flutter for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=2277e4c9010b0f27585eb0bed0a86d7cbc079354";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; }; 
    in {
      packages = rec {
        listen-blue = pkgs.callPackage ./nix/package.nix { };
        default = listen-blue;
      };
      devShell = pkgs.mkShell {
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
      overlays.default = final: prev: let 
        pkgs = import nixpkgs { 
          inherit (prev) system;
        };
      in {
        listen-blue = pkgs.callPackage ./nix/package.nix { };
      };
    };
}

