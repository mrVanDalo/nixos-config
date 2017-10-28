{ config, lib, pkgs, ... }:

{
  # fix fileSystems.<name>.encrypted - false overwrite
  # --------------------------------------------------
  boot.initrd.luks.cryptoModules = [ "aes" "aes_generic" "blowfish" "twofish" "serpent" "cbc" "xts" "lrw" "sha1" "sha256" "sha512" "aes_x86_64" ];

  # lvm volume group
  # ----------------
  boot.initrd.luks.devices = [
    {
      name = "vg";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];

  # NTFS support
  # ------------
  environment.systemPackages = [
    pkgs.ntfs3g
  ];  

  # root
  # ----
  fileSystems."/" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/vg/root";
    fsType = "ext4";
  };

  # boot
  # ----
  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
  };

  # home
  # ----
  fileSystems."/home" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/vg/home";
    fsType = "ext4";
  };

  # home/steam
  # ----------
  fileSystems."/home/steam" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/steam";
    fsType = "ext4";
  };

  # home/browser-tmp
  # ----------
  fileSystems."/home/browser-tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  # home/music
  # ----------
  fileSystems."/home/music" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/music";
    fsType = "ext4";
  };

  # home/video
  # ----------
  fileSystems."/home/video" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/video";
    fsType = "ext4";
  };

  # home/palo/.Private
  # ------------------
  fileSystems."/home/palo/.Private" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/private";
    fsType = "ext4";
  };

  # home/palo/dev
  # --------------
  fileSystems."/home/palo/dev" = {
    options   = [ "noatime" "nodiratime" ];
    device    = "/dev/mapper/development_decrypted";
    fsType    = "ext4";
    encrypted = {
      enable  = true;
      keyFile = "/mnt-root/root/keys/development.key";  
      label   = "development_decrypted";
      blkDev  = "/dev/mapper/store-development";
    };
  };


  # home/palo/audio/projects
  # ------------------
  fileSystems."/home/palo/audio/projects " = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/audio-projects";
    fsType = "ext4";
  };

  # home/palo/audio/samples
  # ------------------
  fileSystems."/home/palo/audio/samples" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/audio-samples";
    fsType = "ext4";
  };



  # var/lib/docker
  # --------------
  fileSystems."/var/lib/docker" = {
    options   = [ "noatime" "nodiratime" ];
    device    = "/dev/mapper/docker_decrypted";
    fsType    = "ext4";
    encrypted = {
      enable  = true;
      keyFile = "/mnt-root/root/keys/docker.key"; 
      label   = "docker_decrypted";
      blkDev  = "/dev/mapper/store-docker";
    };
  };

  # backup
  # ------
  fileSystems."/backup" = {
    options = [ "noatime" "nodiratime" "discard" ];
    device = "/dev/store/backup";
    fsType = "ext4";
  };



}

