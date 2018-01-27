{ config, pkgs, ... }:

{
  imports = [
    ./browser.nix
    ./filesystem.nix
    ./font.nix
    ./development/java.nix
    ./development/haskell.nix
    ./programs/bash.nix
    ./programs/espeak.nix
    ./programs/skype.nix
    ./programs/steam.nix
    ./programs/slack.nix
    ./programs/netflix.nix
    ./programs/transmission.nix
    ./programs/vim.nix
    ./sound.nix
    ./udev_devices.nix
    ./x11.nix
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
    pmount.source  = "${pkgs.pmount}/bin/pmount";
    pumount.source = "${pkgs.pmount}/bin/pumount";
  };


  # Virtualisation
  # --------------
  virtualisation = {

    # docker
    # ------
    docker.enable = true;

    # virtualbox
    # ----------
    virtualbox = {
      guest.x11     = true;
      guest.enable  = true;
      host.enable   = true;
    };
  };

  # automatic mount
  # ---------------
  # don't mount ~/.Private on login
  security.pam.enableEcryptfs = true;

  # network
  # -------
  networking = {
    wireless.enable = true;
    extraHosts = ''
      # None
    '';
  };
  hardware.enableRedistributableFirmware = true;

  # user
  # ---
  users = {
    mutableUsers = true;
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

    # kdenlive
    # --------
    kdeApplications.kdenlive
    frei0r
    breeze-icons

    # stuff
    # ----
    teamspeak_client
    evtest
    gpodder
    freecad
    krita
    libtool
    xdotool
    id3v2
    copyq
    imagemagick
    gimp
    inkscape
    translate-shell
    lsof
    handbrake
    simplescreenrecorder
    audacious
    file
    nmap-graphical
    vagrant
    ansible
    ffmpeg-full
    zip
    unzip
    mixxx
    binutils
    teamspeak_client
    bc
    audacity
    sox
    aspell
    aspellDicts.de
    aspellDicts.en
    aspellDicts.es
    hugo
    xclip
    #jetbrains.clion
    #jetbrains.datagrip
    #jetbrains.pycharm-professional
    #jetbrains.webstorm
    #jetbrains.ruby-mine
    ruby
    nix-index
    wgetpaste
    #cmake
    ncdu
    emacs
    taskjuggler
    taskwarrior
    tasksh
    timewarrior
    #python27Packages.bugwarrior
    #(python27Packages.bugwarrior.overrideAttrs (
    #  oldAttrs: {
    #    name = "bugwarrior-1.5.1";
    #    src = fetchurl {
    #      url = "mirror://pypi/b/bugwarrior/bugwarrior-1.5.1.tar.gz";
    #      sha256 = "0kxknjbw5kchd88i577vlzibg8j60r7zzdhbnragj9wg5s3w60xb";
    #    };
    #  }
    #))

    tmux

    #hlint
    #haskellPackages.apply-refact
    #haskellPackages.stylish-haskell
    #haskellPackages.hoogle
    #haskellPackages.hindent

    dosfstools
    youtube-dl
    pass
    cups
    elixir
    tree
    htop
    lynx
    xtrlock-pam
    mplayer
    vlc
    thunderbird
    darktable
    ecryptfs
    ecryptfs-helper
    dfilemanager
    #blender
    libreoffice
    calibre
    evince

    easytag
    gnome3.dconf


    # root tools
    # ----------
    psmisc            # contains killall

    # docker
    # ------
    docker-machine
    minikube
    docker-machine-kvm
    docker

    # network
    # -------
    iftop
    wpa_supplicant
    python27Packages.glances
    traceroute
    whois
    wireshark
    ipcalc
    sipcalc
    openssh
    wget
    curl
    sshfs
    curlftpfs
    filezilla
    openvpn
    sshuttle
  ];

}

