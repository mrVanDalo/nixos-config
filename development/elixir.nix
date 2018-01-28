{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    git
    tig
    ag
    emacs
    elixir
  ];
}

