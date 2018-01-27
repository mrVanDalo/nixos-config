{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    #package = pkgs.oraclejdk8;
  };

  environment.systemPackages  = with pkgs ; [
    jetbrains.idea-ultimate
    git
    tig
    ag
  ];
}

