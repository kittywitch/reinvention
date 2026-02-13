{ Std }: final: prev: let
  inherit (Std) Set List Tuple Str;
  inherit (prev) lib;
  inherit (lib.filesystem) readDir;
  fileAndFolderNames = Set.keys (readDir ./.);
  packageNames = List.filter (file: file != "default.nix") fileAndFolderNames;
  pkgs = Set.fromList (List.map (path: let
    name = Str.removeSuffix ".nix" path;
    realPath = ./. + "/${path}";
    calledPackage = prev.callPackage realPath {};
  in Tuple.tuple2 name calledPackage) packageNames);
  overrides = {
    
  };
in pkgs // overrides
