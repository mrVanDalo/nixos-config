{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    #package = pkgs.oraclejdk8;
  };
}

