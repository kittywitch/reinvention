{ Std }: final: prev: let
  inherit (Std) Set List Tuple Str;
  inherit (prev) lib;
  inherit (lib.filesystem) readDir;
  pkgs = readDir ./.
    |> Set.keys
    |> List.filter (file: file != "default.nix")
    |> List.map (path: let
      name = Str.removeSuffix ".nix" path;
      realPath = ./. + "/${path}";
      calledPackage = prev.callPackage realPath {};
    in Tuple.tuple2 name calledPackage)
    |> Set.fromList;
  overrides = {
    
  };
in pkgs // overrides
