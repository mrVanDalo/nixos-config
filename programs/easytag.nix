{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    easytag
    gnome3.dconf
  ];
}

