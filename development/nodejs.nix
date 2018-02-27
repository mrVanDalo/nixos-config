{ config, pkgs, ... }:

{
  environment.systemPackages  = with pkgs ; [
    electron
    nodejs-8_x
  ];
}

