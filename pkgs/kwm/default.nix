{
  lib,
  stdenv,
  fetchFromGitHub,
  zig,
  pkg-config,
  wayland,
  wayland-scanner,
  wayland-protocols,
  libxkbcommon,
  pixman,
  fcft,
  callPackage
}: let
    inherit (lib.licenses) gpl3Only;
in stdenv.mkDerivation rec {
  pname = "kwm";
  version = "unstable-2026-02-13_11:31";
  src = fetchFromGitHub {
    owner = "kewuaa";
    repo = pname;
    rev = "34d416202de3b3dead67ae539616852e5e59becf";
    hash = "sha256-I3ZatRXvgTDhz5AS9jLnQQuj9tdLNcam0o+vwjUMcE8=";
  };

  nativeBuildInputs = [
    zig
    pkg-config
    wayland
    wayland-scanner
    wayland-protocols
    libxkbcommon
    pixman
    fcft
  ];
  
  configurePhase = ''
    export ZIG_GLOBAL_CACHE_DIR=$TEMP/.cache
    mkdir -p $ZIG_GLOBAL_CACHE_DIR
    ln -s ${callPackage ./deps.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  meta = {
    homepage = "https://github.com/kewuaa/kwm";
    description = "A window manager based on River Wayland Compositor, written in Zig";
    license = gpl3Only;
  };
}
