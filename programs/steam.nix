{ config, lib, pkgs, ... }:

# steam
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  bin = pkgs.writeShellScriptBin "steam" ''
  /var/run/wrappers/bin/sudo -u steam -i ${pkgs.steam}/bin/steam $@
  '';

in {

  environment.systemPackages = [
    bin
    pkgs.xorg.xhost
    # to use xbox controllers
    pkgs.xboxdrv
  ];

  users.users.steam = {
    isNormalUser = true;
    home = "/home/steam";
    createHome = true;
    extraGroups = [ "audio" "input" ];
  };

  # for steam
  hardware.opengl.driSupport32Bit = true;

  security.sudo.extraConfig = ''
  palo ALL=(steam) NOPASSWD: ALL
  '';
}

