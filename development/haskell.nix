{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    git
    tig
    ag
    hlint
    emacs
    # cabal-install
    ghc
    haskellPackages.ghc-mod
    haskellPackages.apply-refact
    haskellPackages.stylish-haskell
    haskellPackages.hoogle
    haskellPackages.hindent
  ];
}

