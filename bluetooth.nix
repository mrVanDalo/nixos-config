{ config, lib, pkgs, ... }:

{

  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
    extraConfig = ''
    [General]
    AutoConnect=true
    '';
  };

  environment.systemPackages = with pkgs ; [

    # bluetooth audio
    # ---------------
    bluez
    bluez-tools

  ];

}

