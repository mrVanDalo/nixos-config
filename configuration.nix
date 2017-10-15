{ config, pkgs, ... }:

{
	imports = [ 
	./browser.nix 
	./filesystem.nix
	./steam.nix
	./sound.nix
	];

	# will show the configuration.nix which let to the system
	# under /run/current-system/configuration.nix
	system.copySystemConfiguration = true;

 	nixpkgs.config.allowUnfree = true;

	programs.bash.enableCompletion = true;
	
	time.timeZone = "Europe/Berlin"	;

	services.printing.enable = true;

	services.logind.lidSwitch = "lock";

	programs.vim.defaultEditor = true;

	# automatic mount ~/.Private on login
	security.pam.enableEcryptfs = true;

  	environment.systemPackages = with pkgs ; [ 
		
		# stuff
		# ----
		jetbrains.clion
		jetbrains.datagrip
		jetbrains.idea-ultimate
		jetbrains.pycharm-professional
		jetbrains.ruby-mine
		nix-index
		wgetpaste
		cmake
		ncdu
		vim
		vimPlugins.vim-nix
		emacs
		taskwarrior
		tasksh
		python27Packages.bugwarrior
		git
		tig
		tmux
		#haskellPackages.azubi
		dosfstools
		backup
		youtube-dl
		pmount
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
		terminus_font
		terminus_font_ttf
		inconsolata
		xorg.xmodmap
		slack
		file

		# docker
		# ------
		docker-machine
		virtualbox
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
		extraGroups = [ "wheel" "networkmanager" ];
	};

	# network
	# -------
	networking.wireless.enable = true;
	hardware.enableRedistributableFirmware = true;


}

