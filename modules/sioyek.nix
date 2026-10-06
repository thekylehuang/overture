{ pkgs, ... }:
let
  sdk26 = pkgs.apple-sdk_26;

  qt26 = pkgs.qt6.overrideScope (qfinal: qprev: {
    qtbase = qprev.qtbase.overrideAttrs (o: {
      buildInputs = (o.buildInputs or []) ++ [ sdk26 ];
    });
    qt3d = qprev.qt3d.overrideAttrs (o: {
      buildInputs = (o.buildInputs or []) ++ [ sdk26 ];
    });
    qtspeech = qprev.qtspeech.overrideAttrs (o: {
      buildInputs = (o.buildInputs or []) ++ [ sdk26 ];
    });
  });

  sioyek-26 = (pkgs.sioyek.override { qt6 = qt26; }).overrideAttrs (old: {
    version = "2.0.0-unstable-2026-09-24";
    src = pkgs.fetchFromGitHub {
      owner = "ahrm";
      repo = "sioyek";
      rev = "f4609bfbfd53aaa9bb0ca70744df54ebf768fddf";
      hash = "sha256-XgH2h4QaVjypAteR290PswTibNMUY9b5xYGM+rUr5mo=";
    };
    buildInputs = old.buildInputs ++ [ sdk26 ];
    dontWrapQtApps = true;
    postInstall = (old.postInstall or "") + ''
      mkdir -p $out/Applications/sioyek.app/Contents/Resources
      ln -sfn ../MacOS/shaders $out/Applications/sioyek.app/Contents/Resources/shaders
      ln -sfn ../MacOS/prefs.config $out/Applications/sioyek.app/Contents/Resources/prefs.config
      ln -sfn ../MacOS/keys.config $out/Applications/sioyek.app/Contents/Resources/keys.config
      ln -sfn ../MacOS/tutorial.pdf $out/Applications/sioyek.app/Contents/Resources/tutorial.pdf

      cp ${../assets/sioyek.icns} $out/Applications/sioyek.app/Contents/Resources/sioyek.icns
      /usr/bin/plutil -replace CFBundleIconFile -string "sioyek" $out/Applications/sioyek.app/Contents/Info.plist || true

      /usr/bin/codesign --force --deep --sign - --identifier org.sioyek.sioyek $out/Applications/sioyek.app || true
    '';
  });
in {
  home-manager.users.kylehuang = {
    programs.sioyek = {
      enable = true;
      package = sioyek-26;
    };
  };
  environment.systemPackages = [ sioyek-26 ];
}
