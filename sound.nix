{ config, lib, pkgs, ... }:

{

  environment.systemPackages = [
    pkgs.jack2Full
  ];

  sound = { 
    enable = true;
    #extraConfig = ''
    # defaults.pcm.!cart   Babyface2363365
    # defaults.pcm.!device 0
    # defaults.pcm.!ctl    Babyface2363365
    #'';
    extraConfig = ''
      defaults.pcm.!cart   PCH
      defaults.pcm.!device 0
      defaults.pcm.!ctl    PCH
      '';
  };

}
  
