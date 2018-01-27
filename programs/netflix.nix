{ config, lib, pkgs, ... }:

# slack
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let


  # The binary which is wrapped
  # ---------------------------
  binary = "${pkgs.google-chrome}/bin/google-chrome-stable --kiosk https://www.netflix.com/browse";

  program = "netflix";

  # puppet user
  # -----------
  puppet = "browser-netflix";

  # user to who can run the puppet using sudo
  # -----------------------------------------
  master = "palo";


  bin = pkgs.writeShellScriptBin "${program}" ''
  /var/run/wrappers/bin/sudo --user=${puppet} --login  ${binary} $@
  '';

in {

  environment.systemPackages = [
    bin
    pkgs.xorg.xhost
  ];

  users.users.${puppet} = {
    isNormalUser = true;
    home         = "/home/${puppet}";
    createHome   = true;
    extraGroups  = [ "audio" ];
  };

  security.sudo.extraConfig = ''
  ${master} ALL=(${puppet}) NOPASSWD: ALL
  '';
}

