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

    shellAliases = {
      ls      = "ls --color=tty";
      l       = "ls -CFh";
      la      = "ls -Ah";
      ll      = "ls -lh" ;
      lt      = "ls -lct --reverse";
      less    = "less -S";
      irc     = "ssh -t cracksucht.de screen -x";
      top     = "htop";
      todo    = "task todo";
      version = "date '+%Y%m%d%H%M%S'";
      vclip   = "xclip -selection clipboard";
      df      = "df -h";

      timestamp = "date +%Y%m%d%H%M%S";

      nix-search       = "nix-env -qaP";
      nix-list         = "nix-env -qaP \"*\" --description";
      nix-list-haskell = "nix-env -f \"<nixpkgs>\" -qaP -A haskellPackages";
      nix-find         = "clear ; ${pkgs.nix-index}/bin/nix-locate -1 -w";

      nix-show-garbadge-roots = "ls -lh /nix/var/nix/gcroots/auto/";

    };
  };

  environment.systemPackages = [
    pkgs.nix-index
  ];
}

