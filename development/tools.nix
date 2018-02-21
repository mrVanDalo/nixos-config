{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    git
    tig
    ag
    git-big-picture
    gitAndTools.gitflow
    gitAndTools.gitSVN
    gitAndTools.git2cl
  ];
}

