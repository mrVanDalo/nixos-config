{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    jetbrains.idea-ultimate
    elmPackages.elm
    elmPackages.elm-compiler
    elmPackages.elm-format
    elmPackages.elm-make
    elmPackages.elm-reactor
    elm-github-install
    git
    tig
    ag
  ];
}

