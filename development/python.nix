{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    jetbrains.pycharm-professional
    git
    tig
    ag
  ];
}

