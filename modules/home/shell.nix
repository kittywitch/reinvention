{
  programs.nushell = {
    enable = true;
    shellAliases = {
      jjc = "jj commit";
      jjb = "jj bookmark";
      jjgp = "jj git push";
    };
  };
  programs.eza = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;    
  };
  programs.helix = {
    enable = true;
  };
}
