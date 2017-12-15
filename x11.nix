{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;

    # window-manager : Xmonad
    # -----------------------
    desktopManager = {
      default      = "none";
      xterm.enable = false;
    };
    displayManager.lightdm = {
      enable           = true;
      autoLogin.enable = true;
      autoLogin.user   = "palo";
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
    };

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
}

