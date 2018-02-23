{config, pkgs , ... }:

{
  # user
  # ---
  # todo make sure the users only get added when 'docker' or vbox is installed.

  users = {

    mutableUsers     = true;
    defaultUserShell = pkgs.zsh;

    users.mainUser = {
      uid             = 1337;
      isNormalUser    = true;
      initialPassword = "palo";
      extraGroups     = [ "wheel" "networkmanager" "docker" "vboxusers" "transmission" "wireshark" ];
    };
  };
}
