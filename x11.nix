{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;

    # Configure video Drivers
    # -----------------------
    videoDrivers = [ "intel" ];

    # window-manager : Xmonad
    # -----------------------
    desktopManager = {
      default      = "none";
      xterm.enable = false;
    };
    displayManager.lightdm = {
      enable           = true;
      autoLogin.enable = true;
      autoLogin.user   = config.users.users.mainUser.name;
    };
    windowManager = {
      default                       = "xmonad";
      xmonad.enable                 = true;
      xmonad.enableContribAndExtras = true;
    };

    # mouse/touchpad
    # --------------
    libinput = {
      enable             = true;
      disableWhileTyping = true;
      tapping            = true;
      scrollMethod       = "twofinger";
      accelSpeed         = "2";
    };

    # Wacom configuraton
    # ------------------
    modules = [ pkgs.xf86_input_wacom ];
  };

  # Packages
  # --------
  environment.systemPackages = with pkgs ; [

    haskellPackages.xmobar
    dmenu
    arandr
    rxvt_unicode
    xcalib
    maim
    xorg.xmodmap
    feh

  ];

  # Xresources config
  # -----------------
  # spread the Xresource config
  # across different files
  # just add a file into `/etc/X11/Xresource.d/` and it will be
  # evaluated.
  services.xserver.displayManager.sessionCommands = ''
    for file in `ls /etc/X11/Xresource.d/`
    do
      ${pkgs.xorg.xrdb}/bin/xrdb -merge /etc/X11/Xresource.d/$file
    done
  '';
  environment.etc."/X11/Xresource.d/.keep".text = "";

}

