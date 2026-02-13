let
  sources = import ./npins;
  Std = import sources.std;
  inherit (Std) List Tuple Set;
  pkgs = import sources.nixpkgs {
    overlays = [
      (import ./pkgs { inherit Std; })
    ];
  };
  inherit (pkgs) lib;

in rec {
  inherit Std pkgs lib sources;
  hosts = let
    inherit (lib.filesystem) readDir;
    nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";
    builder = { ... }@args: nixosSystem ({
      inherit pkgs;
      specialArgs = {
        inherit Std sources;
      };
    } // args);
  in readDir ./hosts
     |> Set.keys
     |> List.map (name: Tuple.tuple2 name (builder {
    system = "x86_64-linux";
    modules = [
        ./hosts/${name}/configuration.nix
        ./modules/nixos/home.nix
    ];
  }))
  |> Set.fromList;
}
