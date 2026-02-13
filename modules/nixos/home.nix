{ Std, sources, config, ... }: let
  inherit (Std) List;
in {
  imports = [
    (import sources.home-manager {}).nixos
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = List.map (path: "${sources.home-manager}/modules/${path}") [
      "programs/nushell"
      "programs/starship"
      "programs/eza"
      "programs/helix"
    ];
    extraSpecialArgs = {
      inherit Std sources;
      parent = config;
    };
    minimal = true;
  };
}
