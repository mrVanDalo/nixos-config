{ config, pkgs, ... }:

{
  imports = [ 
    ./browser.nix 
    ./filesystem.nix
    ./steam.nix
    ./skype.nix
    ./sound.nix
    ./vim.nix
    ./font.nix
    ./udev_devices.nix
  ];

  # will show the configuration.nix which let to the system
  # under /run/current-system/configuration.nix
  system.copySystemConfiguration = true;

  nixpkgs.config.allowUnfree = true;

  programs.bash.enableCompletion = true;
  
  #time.timeZone = "Europe/Berlin" ;
  time.timeZone = "America/Santiago" ;

  services.printing.enable = true;

  services.logind.lidSwitch = "lock";

  # security wrappers 
  # -----------------
  # ensure that suid flags are set
  security.wrappers = {
    pmount.source = "${pkgs.pmount}/bin/pmount"; 
    pumount.source = "${pkgs.pmount}/bin/pumount";
  };

  # docker
  # ------
  virtualisation.docker.enable = true;

  # virtualbox
  # ----------
  virtualisation.virtualbox = {
    guest.x11     = true;
    guest.enable  = true;
    host.enable   = true;
  };
  
  

  # automatic mount 
  # ---------------
  # ~/.Private on login
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

  # load my overlay
  # ---------------
  nixpkgs.config.packageOverrides = import /home/palo/dev/my-nixpkgs/overlay.nix pkgs;

  environment.systemPackages = with pkgs ; [ 

    # from my overlay
    # ---------------
    memo
    
    # backup
    # ------
    teamspeak_client
    backup
    gnupg
    openssl

    # stuff
    # ----
    nmap-graphical
    vagrant
    ansible
    ffmpeg
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
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    jetbrains.webstorm
    nix-index
    wgetpaste
    cmake
    ncdu
    emacs
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

    git
    tig
    tmux
    #haskellPackages.azubi
    #haskellPackages.hpodder
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
    ack
    thunderbird
    darktable
    ecryptfs
    ecryptfs-helper
    dfilemanager
    blender
    easytag
    libreoffice
    calibre
    evince
    feh
    (bitwig-studio.overrideAttrs (
      oldAttrs: { 
      name = "bitwig-studio-1.3.16";
      src = fetchurl {
            url = "https://downloads.bitwig.com/stable/1.3.16/bitwig-studio-1.3.16.deb";
            sha256 = "0n0fxh9gnmilwskjcayvjsjfcs3fz9hn00wh7b3gg0cv3qqhich8";
          };
      }
    ))


    # x11
    # ---
    xmonad-with-packages
    haskellPackages.xmobar
    dmenu
    arandr
    rxvt_unicode
    xcalib
    maim
    simplescreenrecorder
    audacious
    xorg.xmodmap
    slack
    file

    # docker
    # ------
    docker-machine
    #virtualbox
    minikube
    docker-machine-kvm
    docker  
    
    # network
    # -------
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
  ];

  



  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager.lightdm.enable = true;
    
    # mouse/touchpad
    # --------------
    libinput = {
      enable = true;
      disableWhileTyping = true;
      tapping = true;
      scrollMethod = "twofinger";
    };
  };


  # user
  # ---
  users.mutableUsers = true;
  users.users.palo = {
    uid = 1337;
    isNormalUser = true;
    initialPassword = "palo";
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" ];
  };

}

