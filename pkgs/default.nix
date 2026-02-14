{ Std }: final: prev: let
  inherit (Std) Set List Tuple Str Regex Opt;
  inherit (prev) lib;
  inherit (lib.filesystem) readDir;
  pkgs = readDir ./.
    |> Set.filter (entry: type: let
        filePredicate = type == "regular";
        isDefaultPredicate = entry != "default.nix";
        isNixPredicate = entry
          |> Regex.match "(.*)\\.nix"
          |> Opt.isJust;
        composedFilePredicate = filePredicate
          && isDefaultPredicate
          && isNixPredicate;
        folderPredicate = type == "directory";
      in
        composedFilePredicate || folderPredicate)
    |> Set.keys
    |> List.map (path: let
      name = Str.removeSuffix ".nix" path;
      realPath = ./. + "/${path}";
      calledPackage = prev.callPackage realPath {};
    in Tuple.tuple2 name calledPackage)
    |> Set.fromList;
  overrides = {
    libxkbcommon = prev.libxkbcommon.overrideAttrs {
      version = "1.13.1";
      src = final.fetchFromGitHub {
      owner = "xkbcommon";
        repo = "libxkbcommon";
        tag = "xkbcommon-1.13.1";
        hash = "sha256-wUsxsM0xXTg7nbvFMXrrnHherOepj0YI77eferjRgJA=";
      };
      patches = [
        ./disable-x11com.patch
      ];
    };
  };
in pkgs // overrides
