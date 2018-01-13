{ config, pkgs, ... }:
let

  home = "/home/video/transmission";

in {

  services.transmission = {
    enable = true;
    home = "${home}";
    settings = {

      # Downloads
      download-dir           = "${home}/downloads";
      incomplete-dir-enabled = true;
      incomplete-dir         = "${home}/incomplete";

      # RPC = UI connection
      rpc-bind-address       = "127.0.0.1";
      rpc-whitelist          = "127.0.0.1";
      rpc-user               = "palo";
      rpc-password           = "palo";

      # Start torrents as soon as they are added
      start-added-torrents   = true;

      # Encryption may help get around some ISP filtering,
      # but at the cost of slightly higher CPU use.
      # 0 = Prefer unencrypted connections,
      # 1 = Prefer encrypted connections,
      # 2 = Require encrypted connections; default = 1)
      encryption = 2;

      # Enable Local Peer Discovery (LPD).
      lpd-enabled = true;

      # Enable UPnP or NAT-PMP.
      port-forwarding-enabled = true;

      # Bandwidth (KB/s)
      # Clicking the "Turtle" in the gui when the scheduler is enabled,
      # will only temporarily remove the scheduled limit until the next cycle.
      alt-speed-enabled = true;
      alt-speed-up = 20;
      alt-speed-down = 50;
      # "normal" speed limits
      speed-limit-down-enabled = true;
      speed-limit-down = 400;
      speed-limit-up-enabled = true ;
      speed-limit-up = 50;
      upload-slots-per-torrent = 8;

      # Queuing
      # When true, Transmission will only download
      # download-queue-size non-stalled torrents at once.
      download-queue-enabled = true;
      download-queue-size = 1;

      # When true, torrents that have not shared data for
      # queue-stalled-minutes are treated as 'stalled'
      # and are not counted against the queue-download-size
      # and seed-queue-size limits.
      queue-stalled-enabled = true;
      queue-stalled-minutes = 60;

      # When true. Transmission will only seed seed-queue-size
      # non-stalled torrents at once.
      seed-queue-enabled = true;
      seed-queue-size =  10;

    };
  };

  # Packages
  # --------
  environment.systemPackages = with pkgs ; [
    transmission-remote-cli
    transmission_remote_gtk
  ];
}

