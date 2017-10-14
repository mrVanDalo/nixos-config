{ config, lib, pkgs, ... }:

# browser
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

	bin = pkgs.writeShellScriptBin "browser" ''
	/var/run/wrappers/bin/sudo -u browser -i ${pkgs.chromium}/bin/chromium $@
	'';

in {

	environment.systemPackages = [ 
		bin 
		pkgs.xorg.xhost 
	];

	fileSystems = {
		"/home/browser" = {
			device = "tmpfs";
			fsType = "tmpfs";
		};
	};

	users.users.browser = {
		isNormalUser = true;
		home = "/home/browser";
	};
}
	
