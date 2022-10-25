{
  description = "A Music Player written in Flutter for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    dart-flutter = {
      url = "github:flafydev/dart-flutter-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, nixpkgs, dart-flutter }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              dart-flutter.overlays.default
              self.overlays.default
            ];
          };
        in
        {
          packages = {
            inherit (pkgs) listen-blue;
            default = pkgs.listen-blue;
          };
          devShell = pkgs.mkFlutterShell {
            linux = {
              enable = true;
            };

            buildInputs = with pkgs; [
              gst_all_1.gstreamer
              gst_all_1.gst-libav
              gst_all_1.gst-plugins-base
              gst_all_1.gst-plugins-good
              libunwind
              elfutils
              zstd
              orc
            ];
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

