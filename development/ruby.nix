{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    jetbrains.ruby-mine
    ruby
    git
    tig
    ag
  ];
}

