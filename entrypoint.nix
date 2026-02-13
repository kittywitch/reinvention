let
  sources = import ./npins;
  Std = import sources.std;
  inherit (Std) List Tuple Set;
  pkgs = import sources.nixpkgs {};
  inherit (pkgs) lib;

in rec {
  inherit Std pkgs lib;
  hosts = let
    inherit (lib.filesystem) readDir;
    hostNames = Set.keys (readDir ./hosts);
    builder = { ... }@args: import "${sources.nixpkgs}/nixos/lib/eval-config.nix" ({
      inherit pkgs;
    } // args);
  in Set.fromList (List.map (name: Tuple.tuple2 name (builder {
    system = "x86_64-linux";
    modules = [
        ./hosts/${name}/configuration.nix
    ];
  })) hostNames);
}
