{ config, lib, pkgs, ... }:

let

  # name of the program
  # -------------------
  program = "skype";

  # command that will be firejailed
  # -------------------------------
version = "8.17.76.1";
  skype = pkgs.skypeforlinux.overrideAttrs(
            oldAttrs: {
              version = version;
              src = pkgs.fetchurl {
                url = "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_${version}_amd64.deb";
                sha256 = "15p6xs195i5xx0gzq8hvrf9pyz5zwn6qvwxiy7kzij8lp5b52grr";
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

