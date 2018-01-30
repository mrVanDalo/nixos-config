{ config, lib, pkgs, ... }:

let

  # name of the program
  # -------------------
  program = "netflix";

  # command that will be firejailed
  # -------------------------------
  command = "${pkgs.google-chrome}/bin/google-chrome-stable --kiosk https://www.netflix.com/browse";


  # home-folder chroot
  # ------------------
  home-folder = "~/.firejail-${program}";

  # the script
  # ----------
  bin = pkgs.writeShellScriptBin "${program}" ''
  if [[ ! -d ${home-folder} ]]
  then
    mkdir -p ${home-folder}
  fi

  /var/run/wrappers/bin/firejail \
    --private=${home-folder} \
    ${command}
  '';

in {

  environment.systemPackages = [
    bin
    pkgs.firejail
  ];

}

