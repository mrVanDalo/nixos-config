{ config, lib, pkgs, ... }:

let

  # name of the program
  # -------------------
  program = "skype";

  # command that will be firejailed
  # -------------------------------
  version = "8.15.76.1";
  skype = pkgs.skypeforlinux.overrideAttrs(
            oldAttrs: {
              version = version;
              src = pkgs.fetchurl {
                url = "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_${version}_amd64.deb";
                sha256 = "057v646zp5nlkl9a47ybi1x0pqiflnpcw9y11fb0f3bl1qpjkwga";
              };
            });

  command = "${skype}/bin/skypeforlinux $@";

  # the script
  # ----------
  bin = pkgs.writeShellScriptBin "${program}" ''
  /var/run/wrappers/bin/firejail \
    ${command}
  '';

in {

  environment.systemPackages = [
    bin
    pkgs.firejail
  ];

}

