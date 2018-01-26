{ config, lib, pkgs, ... }:

# slack
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let


  # The binary which is wrapped
  # ---------------------------
  binary = "${pkgs.slack}/bin/slack";

  # puppet user and resuting program name
  # -------------------------------------
  puppet = "slack";

  # user to who can run the puppet using sudo
  # -----------------------------------------
  master = "palo";


  bin = pkgs.writeShellScriptBin "${puppet}" ''
  /var/run/wrappers/bin/sudo --user=${puppet} --login  ${binary} $@
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

