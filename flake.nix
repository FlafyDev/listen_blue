{
  description = "A Music Player written in Flutter for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=2277e4c9010b0f27585eb0bed0a86d7cbc079354";
    flake-utils.url = "github:numtide/flake-utils";
    # flutter-nix.url = "github:ilkecan/flutter-nix";
    pub2nix = {
      url = "github:cir0x/pub2nix";
      flake = false;
    };
  };

  outputs = { self, flake-utils, nixpkgs, pub2nix }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          packages = rec {
            listen-blue = pkgs.callPackage ./nix/package.nix {
              buildFlutterApp = pkgs.callPackage ./nix/build-flutter-app.nix { };
              mkFlutterApp = pkgs.callPackage ./nix/mk-flutter-app.nix { };
            };
            default = listen-blue;
          };
          devShell = pkgs.mkShell {
            packages = [
              (pkgs.writeShellScriptBin "pub2nix-lock" ''
                cp pubspec.lock pub2nix.lock
                ${pkgs.yq}/bin/yq \
                  -r \
                  '.packages[] | select(.source == "hosted") | "\(.description.name) \(.description.url) \(.version)"' \
                  pub2nix.lock |\
                while read name url version; do
                  nix-prefetch-url \
                    $url/packages/$name/versions/$version.tar.gz \
                    --name $name-$version \
                    --type sha256 \
                    --unpack |\
                  while read sha256; do
                    cat <<< $(${pkgs.yq}/bin/yq \
                      -r \
                      -y \
                      --arg name "$name" \
                      --arg sha256 "$sha256" \
                      '.packages[$name] += { "sha256": $sha256 }' \
                      pub2nix.lock) > pub2nix.lock
                  done
                done
              '')
              (pkgs.callPackage ./nix/sdkdeps2nix.nix { })
            ];

            buildInputs = with pkgs; [
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
          };
        in
        {
          listen-blue = pkgs.callPackage ./nix/package.nix { };
        };
    };
}

