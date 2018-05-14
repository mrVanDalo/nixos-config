{ config, pkgs, ... }:

{
  programs.zsh = {
    enable                    = true;
    enableCompletion          = true;
    enableAutosuggestions     = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      custom = "/etc/zshcustom/";
      enable = true;

      # powerline themes
      # ----------------
      #theme = "agnoster";
      theme = "powerlevel9k/powerlevel9k";

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

    loginShellInit = ''
      export TERM="xterm-256color"
    '';
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
      nix-list-node    = "nix-env -f \"<nixpkgs>\" -qaP -A nodePackages";
      nix-find         = "clear ; ${pkgs.nix-index}/bin/nix-locate -1 -w";

      nix-show-garbadge-roots = "ls -lh /nix/var/nix/gcroots/auto/";

    };
  };

  environment.systemPackages = [
    pkgs.nix-index # make nix-index also available to users
  ];


  # Theme
  # -----
  # make sure powerline-fonts is set in `fonts.fonts`
  environment.etc."zshcustom/themes/powerlevel9k".source = pkgs.fetchFromGitHub {
    owner  = "bhilburn";
    repo   = "powerlevel9k";
    rev    = "v0.6.4";
    sha256 = "104wvlni3rilpw9v1dk848lnw8cm8qxl64xs70j04ly4s959dyb5";
  };
  environment.etc."zshcustom/powerlevel9kpatch.zsh".source = pkgs.writeText "powerlevel9kpatch.zsh" ''
    # only used to make quick config changes
    # --------------------------------------
    # source ${config.users.users.mainUser.home}/.zshrc

    # this shows all the colors which are available
    # ---------------------------------------------
    # for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"

    # prompt elements
    # ---------------
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode context dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time)

    # vi mode
    # -------
    POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND="black"
    POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND="blue"
    POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND="black"
    POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND="yellow"

    # context
    # -------
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="green"
    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="008"
    POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="008"
    POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="red"
    POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="008"
    POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="red"

    # dir
    # ---
    POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
    POWERLEVEL9K_DIR_HOME_BACKGROUND="yellow"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="yellow"
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="green"

    # root_indicator
    # --------------
    POWERLEVEL9K_ROOT_ICON="#"
    POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="black"
    POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"

    # background_jobs
    # ---------------
    POWERLEVEL9K_BACKGROUND_JOBS_ICON=""

    # status
    # ------
    POWERLEVEL9K_STATUS_OK_BACKGROUND="008"
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND="008"

    # time
    # ----
    POWERLEVEL9K_TIME_FOREGROUND="008"
    POWERLEVEL9K_TIME_BACKGROUND="006"
  '';

}


