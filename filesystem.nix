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
	];

	# root
	# ----
	fileSystems."/" = {
		#options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/vg/root";
		fsType = "ext4";
	};

	# home
	# ----
	fileSystems."/home/" = {
		#options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/vg/home";
		fsType = "ext4";
	};

	# boot
	# ----
	fileSystems."/boot" = {
		#options = [ "noatime" "nodiratime" "discard" ];
		device = "/dev/sda1";
		fsType = "ext4";
	};

	boot.loader.grub = {
		device = "/dev/sda";
		enable = true;
		version = 2;
	};



}

