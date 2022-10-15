{ stdenv
, makeWrapper
, python310
, flutter
, nix-prefetch
, writeText
, lib
}:
let
  mkPyScript =
    { name
    , pythonLibraries ? (ps: [ ])
    , dependeinces ? [ ]
    , isolate ? true
    , file
    }:
    stdenv.mkDerivation {
      name = name;
      buildInputs = [
        makeWrapper
        (python310.withPackages pythonLibraries)
      ];
      unpackPhase = "true";
      installPhase =
        let
          wrap =
            if isolate
            then "wrapProgram $out/bin/${name} --set PATH ${lib.makeBinPath dependeinces}"
            else "wrapProgram $out/bin/${name} --suffix PATH : ${lib.makeBinPath dependeinces}";
        in
        ''
          mkdir -p $out/bin
          cp ${file} $out/bin/${name}
          chmod +x $out/bin/${name}
          ${wrap}
        '';
    };
in

(mkPyScript {
  name = "sdkdeps2nix";
  dependeinces = [
    nix-prefetch
    flutter.unwrapped
  ];
  file = writeText "sdkdeps2nix.py" ''
    #!/usr/bin/env python3

    from os import listdir
    from os.path import isfile, join, dirname
    from shutil import which
    import subprocess
    import json

    internalDir = join(dirname(str(which('flutter'))), "internal");
    versionFiles = [f for f in listdir(internalDir) if isfile(join(internalDir, f)) and f.endswith(".version")];

    versions = {versionFile.removesuffix(".version"):open(join(internalDir, versionFile)).read().strip() for versionFile in versionFiles};

    prefix = "https://storage.googleapis.com";

    # sanitizeDerivationName
    def san(name: str):
        return name.replace("_", "-").replace("/", "-");

    def mk_engine_dep(name: str):
        return { san(name): {
            "url": f"{prefix}/flutter_infra_release/flutter/{versions['engine']}/{name}.zip",
            "stripRoot": "/" not in name,
            } };

    def mk_ios_usb_dep(name: str):
        return { san(name): {
            "url": f"{prefix}/flutter_infra_release/ios-usb-dependencies/{name}/{versions[name]}/{name}.zip",
            "stripRoot": False,
            } };

    def mk_dep(name: str):
        return { san(name): {
            "url": f"{prefix}/{versions[name]}",
            "stripRoot": False,
            } };


    sdkdeps = (
        mk_engine_dep("flutter_patched_sdk") |
        mk_engine_dep("flutter_patched_sdk_product") |
        mk_engine_dep("linux-x64/artifacts") |
        mk_engine_dep("linux-x64/font-subset") |
        mk_engine_dep("sky_engine") |

        mk_dep("gradle_wrapper") |
        mk_dep("material_fonts") |

        mk_ios_usb_dep("ios-deploy") |
        mk_ios_usb_dep("libimobiledevice") |
        mk_ios_usb_dep("libplist") |
        mk_ios_usb_dep("openssl") |
        mk_ios_usb_dep("usbmuxd") |

        mk_engine_dep("linux-x64-profile/linux-x64-flutter-gtk") |
        mk_engine_dep("linux-x64-release/linux-x64-flutter-gtk") |
        mk_engine_dep("linux-x64/linux-x64-flutter-gtk")
    );

    def hash_dep(dep):
        print(f"Downloading {dep['url']}")
        res = subprocess.check_output(["nix-prefetch",
                          "fetchzip",
                          "--url",
                          dep["url"],
                          "--silent",
                          "--stripRoot" if dep["stripRoot"] else "--no-stripRoot",
                          ], encoding="utf-8").strip()

        if not res.startswith("sha256"):
            raise Exception(f"Couldn't get hash for {dep['url']}.\nGot: {res}")

        dep["hash"] = res;

    for sdkdep in sdkdeps.values():
        hash_dep(sdkdep)

    open("sdkdeps2nix.lock", "w").write(json.dumps(
        sdkdeps,
        sort_keys=True,
        indent=4,
        separators=(',', ': ')
    ))
  '';
})
