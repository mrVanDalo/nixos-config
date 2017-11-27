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
    pkgs.ladspaPlugins
    pkgs.ladspa-sdk
    # pkgs.renoise
  ];

  sound = {
    enable = true;
    extraConfig = ''
      defaults.pcm.!cart   PCH
      defaults.pcm.!device 0
      defaults.pcm.!ctl    PCH

      pcm.mplayer{
        type plug
        slave.pcm "mplayer_limiter";
      }
      pcm.mplayer_limiter{
        type ladspa
        path "${pkgs.ladspaPlugins}/lib/ladspa";
        slave.pcm default
        plugins [
          { label dysonCompress
              input {
                controls [
                  0   # peak limit
                  2   # release time
                  0.2 # fast ratio
                  0.8 # ratio
                ]
              }
          }
          { label fastLookaheadLimiter
            input {
              controls [
                30  # InputGain(Db) -20 -> +20
                -10 # Limit (db) -20 -> 0
                1.1 # Release time (s) 0.01 -> 2
              ]
            }
          }
        ]
      }

      '';
  };

  programs.bash.interactiveShellInit = ''
    # set ladspa library path
    # about testing the plugins check analyseplugin command
    export LADSPA_PATH=${pkgs.ladspaPlugins}/lib/ladspa
  '';

  # todo : this is not working yet
  #imports = [
  #  ( usb_asound_config     "baby" "Babyface2363365" "0" )
  #  ( default_asound_config        "PCH"             "0" )
  #];

}

