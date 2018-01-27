{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    git
    tig
    ag
    hlint
    emacs
    haskellPackages.apply-refact
    haskellPackages.stylish-haskell
    haskellPackages.hoogle
    haskellPackages.hindent
  ];
}

