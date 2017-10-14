{ config, pkgs, ... }:

{
	imports = [ 
	# <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix> 
	./browser.nix 
	./filesystem.nix
	./steam.nix
	];

	system.copySystemConfiguration = true;
 	nixpkgs.config.allowUnfree = true;
	programs.bash.enableCompletion = true;

	# automatic mount ~/.Private on login
	security.pam.enableEcryptfs = true;

  	environment.systemPackages = with pkgs ; [ 
		# stuff
		# ----
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
		#xorg.xf86inputsynaptics
		xorg.xmodmap

		# docker
		# ------
		docker-machine
		virtualbox
		minikube
		docker-machine-kvm
		docker	
		
		# netowrk
		# -------
		wpa_supplicant
		python27Packages.glances
		traceroute
		whois
		wireshark
		ipcalc
		sipcalc
		openssh
		
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

	programs.vim.defaultEditor = true;

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

