{ config, lib, pkgs, ... }:

{

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
  
