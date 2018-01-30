{ config, lib, pkgs, ... }:

let

  # name of the program
  # -------------------
  program = "slack";

  # command that will be firejailed
  # -------------------------------
  command = "${pkgs.slack}/bin/slack";

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

