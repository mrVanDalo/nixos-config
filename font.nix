{ config, libs, pkgs, ... }:

{

  # font configuration
  # ------------------
  fonts = {

    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "inconsolata" ];
      };
    };

    fonts = with pkgs; [
      corefonts
      hasklig
      inconsolata
      source-code-pro
      symbola
      ubuntu_font_family

      # shell font
      # ----------
      terminus_font
      gohufont
    ];
  };

}
