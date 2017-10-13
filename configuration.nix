{ config, pkgs, ... }:

{
	imports = [ 
	# <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix> 
	./browser.nix 
	./filesystem.nix
	];

	system.copySystemConfiguration = true;

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
		xorg.xf86inputsynaptics
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
		windowManager.xmonad = {
			enable = true;
			enableContribAndExtras = true;
		};
		desktopManager.default = "none";
		desktopManager.xterm.enable = false;
		displayManager.lightdm.enable = true;
		enable = true;
		synaptics.enable = true;
	};
	fileSystems = {
		"/home/browser" = {
			device = "tmpfs";
			fsType = "tmpfs";
		};
	};
	
	# user
	# ---
	programs.vim.defaultEditor = true;
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

