{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdeApplications.kdenlive
    frei0r
    breeze-icons
    ffmpeg-full
  ];
}

