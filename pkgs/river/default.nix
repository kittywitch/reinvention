{
  lib,
  stdenv,
  fetchFromCodeberg,
  zig,
  pkg-config,
  libevdev,
  wlroots_0_19,
  wayland,
  wayland-scanner,
  wayland-protocols,
  libxkbcommon,
  pixman,
  fcft,
  scdoc,
  callPackage
}: let
    inherit (lib.licenses) gpl3Only;
in stdenv.mkDerivation rec {
  pname = "river";
  version = "unstable-2026-02-13_02:37";
  src = fetchFromCodeberg {
    owner = pname;
    repo = pname;
    rev = "3d81ed9905e92c110f2b36f3a4b15f55adf93101";
    hash = "sha256-ZF9eHnL8CevGe8wTH+z6IPD1LIC5GerQtPokU1kSX24=";
  };

  nativeBuildInputs = [
    zig
    pkg-config
    libevdev
    wlroots_0_19
    wayland
    wayland-scanner
    wayland-protocols
    libxkbcommon
    pixman
    fcft
    scdoc
  ];
  
  configurePhase = ''
    export ZIG_GLOBAL_CACHE_DIR=$TEMP/.cache
    mkdir -p $ZIG_GLOBAL_CACHE_DIR
    ln -s ${callPackage ./deps.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  meta = {
    homepage = "https://codeberg.org/river/river";
    description = "River is a non-monolithic Wayland compositor.";
    license = gpl3Only;
  };
}
