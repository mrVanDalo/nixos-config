{ config, lib, pkgs, ... }:

{

  # add virtual midi module
  # -----------------------
  boot = {
    # to route midi signals
    # between bitwig and vcvrack
    kernelModules = [ "snd_virmidi" ];
    # index=-2  prevents from beeing recognised as the default
    #           audio device
    # midi_devs limit the number of midi devices.
    extraModprobeConfig = "options snd-virmidi index=-2 midi_devs=1";
  };

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

  environment.systemPackages = [
    pkgs.jack2Full
    pkgs.ladspaPlugins
    pkgs.ladspa-sdk
    # pkgs.renoise
  ];
}

