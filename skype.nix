{ config, lib, pkgs, ... }:

# skype
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  puppet = "skype";
  master = "palo";
  skype = pkgs.skypeforlinux.overrideAttrs(
            oldAttrs: {
              name = "skypeforlinux-8.12.76.2";
              src = pkgs.fetchurl {
                url = "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.12.76.2_amd64.deb";
                sha256 = "04lz96y5svxnv3hzi23gkfr3cvx8mirc7lb0cdv62diiy7cpi8hb";
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

