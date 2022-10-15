{ lib
, flutter
, buildFlutterApp
, mkFlutterApp
, makeWrapper
, pciutils
, gst_all_1
, libunwind
, elfutils
, zstd
, orc
, cmake
, cairo
, SDL2
}:

# mkFlutterApp {
#   pname = "listen-blue";
#   version = "0.0.1";
#
#   src = ../.;
#   vendorHash = "sha256-x6o23pvb2NxAKMhrofYEcLdcrhAHyupvZBGa73MkhwY=";
#   # vendorHashSha256 = lib.fakeSha256;
#
#   nativeBuildInputs = [
#     gst_all_1.gstreamer
#     gst_all_1.gst-libav
#     gst_all_1.gst-plugins-base
#     gst_all_1.gst-plugins-good
#     libunwind
#     elfutils
#     zstd
#     orc
#   ];
# 
#   # buildInputs = [
#   #   gst_all_1.gstreamer
#   #   gst_all_1.gst-libav
#   #   gst_all_1.gst-plugins-base
#   #   gst_all_1.gst-plugins-good
#   #   libunwind
#   #   elfutils
#   #   zstd
#   #   orc
#   # ];
# }

buildFlutterApp {
  pname = "listen_blue";
  platform = "linux";
  lockFile = ../pub2nix.lock;
  specFile = ../pubspec.yaml;
  version = "0.0.1";

  # src = lib.cleanSourceWith {
  #   src = ../.;
  #   filter = (name: type:
  #     !(baseNameOf name == "nix" || baseNameOf name == "README.md"));
  # };
  src = ../.;

  # vendorHashSha256 = lib.fakeSha256;
  # vendorHash = "sha256-hpnxRZkGUGnkDQU1+LjbsfQoHp96s6It34CvzY1bsX0=";

  # buildInputs = [
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
  # buildInputs = [
  #   gst_all_1.gstreamer
  #   gst_all_1.gst-libav
  #   gst_all_1.gst-plugins-base
  #   gst_all_1.gst-plugins-good
  #   libunwind
  #   elfutils
  #   zstd
  #   orc
  # ];

  # postFixup = ''
  #   wrapProgram $out/bin/guifetch --suffix PATH : ${lib.makeBinPath [ pciutils ]}
  # '';

  meta = with lib; {
    description = "A Music Player written in Flutter for Linux";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
