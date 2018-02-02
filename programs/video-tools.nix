{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    youtube-dl
    mplayer

    # to record your screen
    # ---------------------
    simplescreenrecorder

    # to transcode video material
    # ---------------------------
    handbrake
    ffmpeg-full

    # video editing
    # -------------
    openshot-qt

  ];
}

