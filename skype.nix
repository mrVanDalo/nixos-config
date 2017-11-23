{ config, lib, pkgs, ... }:

# skype
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  puppet = "skype";
  master = "palo";

  bin = pkgs.writeShellScriptBin "${puppet}" ''
  /var/run/wrappers/bin/sudo --user=${puppet} --login  ${pkgs.skype}/bin/skypeforlinux $@
  '';

in {

  environment.systemPackages = [
    bin
    pkgs.xorg.xhost
  ];

  users.users.${puppet} = {
    isNormalUser = true;
    home = "/home/${puppet}";
    createHome = true;
    extraGroups = [ "audio" "video" ];
  };

  security.sudo.extraConfig = ''
  ${master} ALL=(${puppet}) NOPASSWD: ALL
  '';
}

