{config, pkgs , ... }:

{
  # user
  # ---
  # todo make sure the users only get added when 'docker' or vbox is installed.

  users = {

    mutableUsers     = true;
    defaultUserShell = pkgs.zsh;

    users.mainUser = {
      isNormalUser    = true;
      name            = "palo";
      uid             = 1337;
      home            = "/home/palo";
      initialPassword = "palo";
      extraGroups     = [ "wheel" "networkmanager" "docker" "vboxusers" "transmission" "wireshark" ];
    };
  };
}
