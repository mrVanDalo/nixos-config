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

  # LADSPA
  # ------
  programs.bash.interactiveShellInit = ''
    # set ladspa library path
    # about testing the plugins check analyseplugin command
    export LADSPA_PATH=${pkgs.ladspaPlugins}/lib/ladspa
  '';

  # PulseAudio
  # ----------
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioLight.override {
      jackaudioSupport = true;
      bluetoothSupport = true;
    };
    extraConfig = ''
      # automatically switch to newly-connected devices
      load-module module-switch-on-connect
    '';
  };

  # Packages needed
  # ---------------
  environment.systemPackages = with pkgs ; [
    # LADSPA
    # ------
    ladspaPlugins
    ladspa-sdk

    # PulseAudio control
    # ------------------
    pavucontrol
    lxqt.pavucontrol-qt
  ];

}

