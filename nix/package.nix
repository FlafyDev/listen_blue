{ lib
, buildFlutterApp
, gst_all_1
, libunwind
, elfutils
, zstd
, orc
}:

buildFlutterApp {
  pname = "listen_blue";
  version = "0.0.1";

  src = ../.;

  buildInputs = [
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    libunwind
    elfutils
    zstd
    orc
  ];

  meta = with lib; {
    description = "A Music Player written in Flutter for Linux";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
