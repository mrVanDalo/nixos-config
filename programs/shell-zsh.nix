{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "dieter";
      plugins = [
        "cabal"
        "docker"
        "git"
        "git-flow"
        "git-prompt"
        "gitignore"
        "mvn"
        "node"
        "npm"
        "pass"
        "rake"
        "sbt"
        "scala"
        "screen"
        "sudo"
        "systemd"
        "taskwarrior"
        "tmux"
        "vi-mode"
        "wd"
      ];
    };
  };
}

