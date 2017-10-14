{ config, lib, pkgs, ... }:

{

	# lvm volume group
	# ----------------
	boot.initrd.luks.devices = [
		{
			name = "vg";
			device = "/dev/sda2";
			preLVM = true;
		}
#			{
#				name = "docker_decrypted";
#				device = "/dev/store/docker";
#				preLVM = false;
#				keyFile = "/root/keys/docker.key";	
#			}
#			{
#				name = "development_decrypted";
#				device = "/dev/store/development";
#				preLVM = false;
#				keyFile = "/root/keys/development.key";	
#			}
		
	];

	environment.systemPackages = [
		pkgs.ntfs3g
	];	

	# root
	# ----
	fileSystems."/" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/vg/root";
		fsType = "ext4";
	};

	# boot
	# ----
	fileSystems."/boot" = {
		device = "/dev/sda1";
		fsType = "ext4";
	};
	boot.loader.grub = {
		device = "/dev/sda";
		enable = true;
		version = 2;
	};

	# home
	# ----
	fileSystems."/home" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/vg/home";
		fsType = "ext4";
	};

	# home/steam
	# ----------
	fileSystems."/home/steam" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/store/steam";
		fsType = "ext4";
	};


	# home/music
	# ----------
	fileSystems."/home/music" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/store/music";
		fsType = "ext4";
	};

	# home/video
	# ----------
	fileSystems."/home/video" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/store/video";
		fsType = "ext4";
	};

	# home/palo/.Private
	# ------------------
	fileSystems."/home/palo/.Private" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/store/private";
		fsType = "ext4";
	};

	# home/palo/dev
	# ------------------
#	fileSystems."/home/palo/dev" = {
#		options = [ "noatime" "nodiratime" "discard" ];
#		device = "/dev/store/development_decrypted";
#		fsType = "ext4";
#	};

	# var/lib/docker
	# ------------------
#	fileSystems."/var/lib/docker" = {
#		options = [ "noatime" "nodiratime" "discard" ];
#		device = "/dev/store/docker_decrypted";
#		fsType = "ext4";
#	};

	# backup
	# ------
	fileSystems."/backup" = {
		options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/store/backup";
		fsType = "ext4";
	};



}

