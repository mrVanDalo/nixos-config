{ config, pkgs, ... }:

{

  networking = {
    wireless.enable = true;
    extraHosts = ''
      # None
    '';
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
    iftop        # show bandwith usage, maybe netsniff-ng has better tools

    # intranet
    # --------
    openvpn
    sshuttle

    # network filesystems
    # -------------------
    sshfs
    curlftpfs

  ];

}

