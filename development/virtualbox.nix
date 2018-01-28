{ config, pkgs, ... }:

{

  virtualisation = {

    virtualbox = {
      guest.x11     = true;
      guest.enable  = true;
      host.enable   = true;
    };

  };

  environment.systemPackages  = with pkgs ; [
    vagrant
  ];
}

