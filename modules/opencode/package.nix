{ lib, stdenv, fetchurl, autoPatchelfHook }:
let
  version = "2.1.1";
  target = {
    "x86_64-linux" = "linux-x64";
    "aarch64-linux" = "linux-arm64";
  }.${stdenv.hostPlatform.system} or (throw "opencode v2: unsupported platform ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "opencode";
  inherit version;

  src = fetchurl {
    # Upstream publishes v2 only via npm (@opencode/cli-*-* tarballs).
    url = "https://registry.npmjs.org/@opencode/cli-${target}/-/cli-${target}-${version}.tgz";
    hash = "sha256-ZFkQV+pZPpoRN01GMMIkmTDY8zWYrws+AhN0k4YKsXs=";
  };

  dontStrip = true;
  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/opencode $out/bin/opencode
    ln -s opencode $out/bin/opencode2 # legacy beta binary name
    runHook postInstall
  '';

  meta = {
    description = "AI coding agent built for the terminal";
    homepage = "https://opencode.ai";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "opencode";
  };
}
