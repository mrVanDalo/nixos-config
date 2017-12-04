{ config, lib, pkgs, ... }:

let

  # active plugins
  # --------------
  extra-runtimepath = lib.concatMapStringsSep "," (pkg: "${pkg.rtp}") [
    pkgs.vimPlugins.ack-vim
    pkgs.vimPlugins.Syntastic
    pkgs.vimPlugins.vim-nix
    pkgs.vimPlugins.airline
  ];

  # the vimrc
  # ---------
  vimrc = pkgs.writeText "vimrc" ''

    " show Trailing Whitespaces
    :set list listchars=tab:»·,trail:¶

    " Map leader is the key for shortcuts
    let mapleader = ","

    " move blocks of text in visual mode
    " does not work correctly
    vmap <up> xkP`[V`]
    vmap <down> xp`[V`]

    "always use 'very magic' regexes
    nmap / /\v

    " tabs should always be 2 spaces
    set et ts=2 sts=2 sw=2

    " installed vim-plugins
    set runtimepath=${extra-runtimepath},$VIMRUNTIME

    " syntax highlighting on
    syntax on

  '';

in {

  # create vimrc
  # ------------
  # and load it as config for vim
  environment.variables.VIMINIT = ":so /etc/vimrc";
  environment.etc.vimrc.source = vimrc;

  # set vim to the default editor
  # -----------------------------
  programs.vim.defaultEditor = true;

  # install vim
  # -----------
  environment.systemPackages = [
    pkgs.vim
  ];

}
