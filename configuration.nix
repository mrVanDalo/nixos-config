{ config, pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./filesystem.nix
    ./font.nix
    ./network.nix
    ./sound-pulse.nix
    ./bluetooth.nix
    ./udev_devices.nix
    ./x11.nix

    # development
    # -----------
    ./development/haskell.nix
    ./development/java.nix
    ./development/ruby.nix
    ./development/python.nix
    ./development/elixir.nix
    ./development/virtualbox.nix
    ./development/docker.nix

    # programs
    # --------
    ./programs/shell-bash.nix
    ./programs/shell-zsh.nix
    ./programs/espeak.nix
    ./programs/steam.nix
    ./programs/transmission.nix
    ./programs/vim.nix
    ./programs/video-tools.nix
    ./programs/easytag.nix
    ./programs/skype-firejail.nix
    ./programs/slack-firejail.nix
    ./programs/netflix-firejail.nix
  ];

  # load my overlay
  # ---------------
  nixpkgs.config.packageOverrides = import /home/palo/dev/nixoverlay/mrVanDalo-overlay.nix pkgs;

  # will show the configuration.nix which let to the system
  # under /run/current-system/configuration.nix
  system.copySystemConfiguration = true;

  nixpkgs.config.allowUnfree = true;

  # tzselect
  # --------
  # to find out which string to use
  #time.timeZone = "Europe/Berlin" ;
  time.timeZone = "Pacific/Auckland" ;

  services.printing.enable = true;

  services.logind.lidSwitch = "lock";

  # security wrappers
  # -----------------
  # ensure that suid flags are set
  security.wrappers = {
    pmount.source   = "${pkgs.pmount}/bin/pmount";
    pumount.source  = "${pkgs.pmount}/bin/pumount";
    firejail.source = "${pkgs.firejail}/bin/firejail";
  };

  # automatic mount
  # ---------------
  # don't mount ~/.Private on login
  security.pam.enableEcryptfs = true;

  # user
  # ---
  # todo make sure the users only get added when 'docker' or vbox is installed.
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.palo = {
      uid = 1337;
      isNormalUser = true;
      initialPassword = "palo";
      extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "transmission" "wireshark" ];
    };
  };


  # Packages
  # --------
  environment.systemPackages = with pkgs ; [

    # my overlay
    # ----------
    memo
    pencil
    bitwig-studio
    vcvrack

    # backup
    # ------
    backup
    gpa
    gnupg
    openssl

    # crypt
    # -----
    ecryptfs
    ecryptfs-helper
    pass

    # image programms
    # ---------------
    darktable
    imagemagick
    krita
    gimp
    inkscape
    blender

    # music tools
    # -----------
    audacious
    mixxx
    audacity
    sox
    id3v2

    # spelling
    # --------
    aspell
    aspellDicts.de
    aspellDicts.en
    aspellDicts.es
    translate-shell

    # time-management
    # ---------------
    taskjuggler
    taskwarrior
    tasksh
    timewarrior

    # root tools
    # ----------
    psmisc                   # contains killall
    python27Packages.glances # system monitor

    # stuff (sort)
    # ----
    teamspeak_client
    firejail
    gpodder
    freemind
    freecad
    copyq
    lsof
    tree
    file
    zip unzip
    bc
    wgetpaste
    ncdu
    emacs
    hugo
    xclip
    tmux
    dosfstools
    cups
    htop
    lynx
    xtrlock-pam
    thunderbird
    xfe                 # filemanager
    libreoffice
    calibre
    evince
    jetbrains.datagrip  # all the others are in ./development
    ansible
    ion

  ];

}

