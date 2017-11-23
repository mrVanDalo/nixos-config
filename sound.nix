{ config, lib, pkgs, ... }:

let

  default_asound_config = card: device:
    let
      name = "default";
    in {

      environment.etc."asound.conf_${name}" = {
        text = ''
          defaults.pcm.!cart   ${card}
          defaults.pcm.!device ${device}
          defaults.pcm.!ctl    ${card}
        '';
      };

    };

  # create an asound.conf
  # ---------------------
  # for a soundcard as default card
  usb_asound_config = name: card: device:

    let
      add_script = pkgs.writeScriptBin "asound_add_${name}" ''
        #!/usr/bin/env bash
        rm /etc/asound.conf
        ln -s /etc/asound.conf_${name} /etc/asound.conf
      '';

      remove_script = pkgs.writeScriptBin "asound_remove_${name}" ''
        #!/usr/bin/env bash
        rm /etc/asound.conf
        ln -s /etc/asound.conf_default /etc/asound.conf
      '';

    in {

      environment.etc."asound.conf_${name}" = {
        text = ''
          defaults.pcm.!cart   ${card}
          defaults.pcm.!device ${device}
          defaults.pcm.!ctl    ${card}
        '';
      };

      environment.systemPackages = [
        add_script
        remove_script
      ];

      services.udev.extraRules = ''
        # ${name}
        # for information : udevadm info -a /dev/sdc
        ACTION=="add",    SUBSYSTEM=="sound", ATTR{id}=="${card}", RUN+="${add_script}/bin/asound_add_${name}"
        ACTION=="remove", SUBSYSTEM=="sound", ATTR{id}=="${card}", RUN+="${remove_script}/bin/asound_remove_${name}"
      '';

    };


in {

  environment.systemPackages = [
    pkgs.jack2Full
  ];

  sound = {
    enable = true;
    extraConfig = ''
      defaults.pcm.!cart   PCH
      defaults.pcm.!device 0
      defaults.pcm.!ctl    PCH
      '';
  };

  # todo : this is not working yet
  #imports = [
  #  ( usb_asound_config     "baby" "Babyface2363365" "0" )
  #  ( default_asound_config        "PCH"             "0" )
  #];

}

