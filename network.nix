{ config, pkgs, ... }:

{

  networking = {
    wireless.enable = true;
    hostName = "workhorse";
    extraHosts = ''
      # Nothing so far
    '';
  };

  services.openssh = {

    # don't run ssh server
    # --------------------
    enable = false;

    # allow only long via ssh-key
    # ---------------------------
    passwordAuthentication = false;

    # don't allow to login as root user
    # ---------------------------------
    permitRootLogin = "no";

    # don't allow to foward X
    # -----------------------
    forwardX11 = false;

  };

  # enable for intel wifi drivers
  # -----------------------------
  hardware.enableRedistributableFirmware = true;

  # Packages
  # --------
  environment.systemPackages = with pkgs ; [

    wpa_supplicant
    openssh

    # tools
    # -----
    wget
    curl
    ipcalc
    sipcalc
    filezilla

    # analyse
    # -------
    nmap-graphical
    wireshark
    whois
    traceroute
    netsniff-ng

    # intranet
    # --------
    openvpn
    sshuttle

    # network filesystems
    # -------------------
    sshfs
    curlftpfs

    (pkgs.writeShellScriptBin "scan-wifi" ''
    # todo : use column to make a nice view
    ${wirelesstools}/bin/iwlist scan | \
      grep -v "Interface doesn't support scanning" | \
      sed -e '/^\s*$/d' | \
      grep -e "ESSID" -e "Encrypt" | \
      sed -e "s/Encryption key:on/encrypted/g" | \
      sed -e "s/Encryption key:off/open/g" | \
      sed -e "s/ESSID://g" | \
      xargs -L 2 printf "%9s - '%s'\n"
    '')

    (pkgs.writeShellScriptBin "network-monitor" ''
      #!/usr/bin/env bash

      tmux start-server
      tmux new-session -d

      tmux set -g mouse on
      tmux set -g mouse-select-pane on

      # create a journalctl on the bottom and give it 25%
      tmux split-window -d -t 0 -v -p 15
      tmux send-keys    -t 1 "clear ; journalctl -f" enter

      # create a split to see internet trafic
      tmux split-window -b -t 0 -d -v -p 50
      tmux send-keys    -t 1 "clear ; ifpps wlp3s0 " enter
      tmux split-window -b -t 1 -d -h -p 50
      tmux send-keys    -t 1 "clear ; sudo flowtop" enter

      # create a split to see open ports
      tmux split-window -b -t 0 -d -h -p 50
      tmux send-keys    -t 0 "watch netstat -tulpn" enter
      tmux send-keys    -t 1 "top" enter

      tmux attach
    '')

  ];

}

