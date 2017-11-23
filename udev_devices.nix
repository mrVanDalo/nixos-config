{ config, lib, pkgs, ... }:

{

  # add some devices
  # ----------------
  # which I use a lot
  services.udev.extraRules = ''
    # common storages I use
    # ---------------------
    # for information : udevadm info -a /dev/sdc
    ATTRS{vendor}=="GoPro   ", ATTRS{model}=="Storage         ", SYMLINK+="gopro%n"
    ATTRS{vendor}=="Kindle  ", ATTRS{model}=="Internal Storage", SYMLINK+="kindle%n"
    ATTRS{vendor}=="TOSHIBA ", ATTRS{model}=="External USB 3.0", SYMLINK+="frog%n"
    ATTRS{vendor}=="Toshiba ", ATTRS{model}=="External USB 3.0", SYMLINK+="platin%n"
    ATTRS{vendor}=="Teenage ", ATTRS{model}=="OP-1            ", SYMLINK+="op1"
    ATTRS{type}=="SD",         ATTRS{serial}=="0x45b602a3",      SYMLINK+="photo"
  '';

}

