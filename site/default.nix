{ stdenv, glibcLocales, callPackage }:
let
  builder = callPackage ../builder {};
in
  stdenv.mkDerivation {
    name = "bradparker-com-site";
    src = ./.;
    buildInputs = [ glibcLocales ];
    buildPhase = ''
      export LOCALE_ARCHIVE="${glibcLocales}/lib/locale/locale-archive"
      export LANG="en_AU.UTF-8";
      export LC_TYPE="en_AU.UTF-8";

      ${builder}/bin/builder build
    '';
    installPhase = ''
      mkdir -p $out/var/www/bradparker.com/
      cp -R _site/* $out/var/www/bradparker.com/
    '';
  }
