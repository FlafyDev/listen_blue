{ lib, 
  flutter,
  makeWrapper,
  pciutils,
  gst_all_1,
  libunwind,
  elfutils,
  zstd,
}:

flutter.mkFlutterApp {
  pname = "listen-blue";
  version = "0.0.3";

  src = lib.cleanSourceWith {
    src = ../.;
    filter = (name: type: 
      !(baseNameOf name == "nix" || baseNameOf name == "README.md"));
  };

  vendorHashSha256 = lib.fakeSha256;
  # vendorHash = "sha256-Vgow3zza/ojLjjZovUi2Mmbq1VfAN4VWHRtX6IGvwkY=";

  nativeBuildInputs = [ makeWrapper ];

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

  # postFixup = ''
  #   wrapProgram $out/bin/guifetch --suffix PATH : ${lib.makeBinPath [ pciutils ]}
  # '';

  meta = with lib; {
    description = "A Music Player written in Flutter for Linux";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
