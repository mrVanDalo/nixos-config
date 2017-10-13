{ config, pkgs, ... }:

{
	imports = [ <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix> ];
  	environment.systemPackages = [ 
		pkgs.vim
		pkgs.vimPlugins.vim-nix
		pkgs.xmonad-with-packages
		pkgs.dmenu
		pkgs.taskwarrior
		pkgs.tasksh
		pkgs.python27Packages.bugwarrior
		pkgs.arandr
		pkgs.rxvt_unicode
		pkgs.xcalib
		pkgs.maim
		pkgs.git
		pkgs.tmux
	];
	system.copySystemConfiguration = true;
	services.xserver = {
		windowManager.xmonad.enable = true;
		desktopManager.default = "none";
		desktopManager.xterm.enable = false;
		displayManager.lightdm.enable = true;
		enable = true;
	};
	users.mutableUsers = true;
	users.users.palo = {
		uid = 1338;
		isNormalUser = true;
		initialPassword = "palo";
		extraGroups = [ "wheel" "networkmanager" ];
	};
}

