{ config, lib, pkgs, ... }:

# skype
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  puppet = "skype";
  master = "palo";
  skype = pkgs.skypeforlinux.overrideAttrs(
            oldAttrs: rec {
              version = "8.13.76.8";
              src = pkgs.fetchurl {
                url = "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_${version}_amd64.deb";
                sha256 = "1vmzzbvwjahqg2rssg17jswl9kpv5x9gwd4mg5mgfhq7y29dyx9x";
              };
            });

  bin = pkgs.writeShellScriptBin "${puppet}" ''
  /var/run/wrappers/bin/sudo --user=${puppet} --login  ${skype}/bin/skypeforlinux $@
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

