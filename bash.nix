{ config, pkgs, ... }:
{
  programs.bash = {

    # BashCompletion
    # --------------
    enableCompletion = true;

    # Configure Shell
    # ---------------
    interactiveShellInit = ''
      # use vi shortcuts
      # ----------------
      set -o vi

      # Configure ls-colors
      # -------------------
      export LS_COLORS='rs=0:di=01;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;33:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35::*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
    '';

    # Configure Prompt
    # ----------------
    promptInit = ''
      # PS1 content functions
      # ---------------------
      function nonzero_return() {
        RETVAL=$?
        [ $RETVAL -ne 0 ] && echo "[> $RETVAL <] "
      }

      # Provide a nice prompt
      # ---------------------
      case $TERM in
        xterm*|rxvt*|Eterm)
          # used : http://ezprompt.net/
          USER_COLOR="\[\e[36m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\]"
          CURRENT_PATH="\[\e[33m\][\[\e[m\]\[\e[33m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\]"
          if [[ $UID -eq 0 ]]
          then
            USER_COLOR="\[\e[31m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]"
          fi
          export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[35m\]\A\[\e[m\] $USER_COLOR $CURRENT_PATH\[\e[31m\]\\$\[\e[m\] "
        ;;
        screen)
          export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[35m\]\A\[\e[m\] \[\e[36m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[33m\][\[\e[m\]\[\e[33m\]\W\[\e[m\]\[\e[33m\]]\[\e[m\]\[\e[31m\]\\$\[\e[m\] "
        ;;
      esac
    '';

    # Shell Aliases
    # -------------
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

      nix-search = "nix-env -qaP";
      nix-list   = "nix-env -qaP '*' --description";

    };

  };
}



