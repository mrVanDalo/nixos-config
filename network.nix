{ config, pkgs, ... }:

{

  networking = {
    wireless.enable = true;
    extraHosts = ''
      # None
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
    iftop        # show bandwith usage, maybe netsniff-ng has better tools

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

  ];

}

