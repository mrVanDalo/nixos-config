{ config, lib, pkgs, ... }:

let

  # name of the program
  # -------------------
  program = "skype";

  # command that will be firejailed
  # -------------------------------
version = "8.19.76.3";
  skype = pkgs.skypeforlinux.overrideAttrs(
            oldAttrs: {
              version = version;
              src = pkgs.fetchurl {
                url = "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_${version}_amd64.deb";
                sha256 = "19xdlh6p3hk64x8pk1g0xhvwmlvvim7jd0lwgraqfqmjm9864yna";
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

