{ config, pkgs, ... }:

{

  environment.etc."X11/Xresource.d/urxvt".source = pkgs.writeText "Xresource-urxvt" ''
    !! Perl extensions
    !! ---------------
    URxvt.perl-ext-common:  default,matcher
    URxvt.urgentOnBell:     true

    !! Highlight URLs
    !! --------------
    URxvt.url-launcher:     /run/current-system/sw/bin/browser-select
    URxvt.matcher.button:   1

    !! Font
    !! ----
    URxvt.allow_bold:       true
    URxvt.xftAntialias:     true

    !! use xfontsel or fontmatrix to choose line
    URxvt.font:             -*-terminus-medium-*-*-*-17-*-*-*-*-*-*-*, xft:TerminessTTF Nerd Font:pixelsize=17
    URxvt.boldFont:         -*-terminus-bold-*-*-*-17-*-*-*-*-*-*-*,   xft:TerminessTTF Nerd Font:pixelsize=17
    URxvt.italicFont:       -*-terminus-medium-*-*-*-17-*-*-*-*-*-*-*, xft:TerminessTTF Nerd Font:pixelsize=17
    URxvt.bolditalicFont:   -*-terminus-bold-*-*-*-17-*-*-*-*-*-*-*,   xft:TerminessTTF Nerd Font:pixelsize=17

    !! History
    !! -------
    URxvt.scrollStyle:      rxvt
    URxvt.scrollBar:        false
    URxvt.saveLines:        1000000

    !! Color Configuration
    !! -------------------

    !! make sure unselected terminals are not graded out.
    URxvt.fading:           0

    !! Common
    !! ------
    #define S_yellow                #b58900
    #define S_orange                #cb4b16
    #define S_red                   #dc322f
    #define S_magenta               #d33682
    #define S_violet                #6c71c4
    #define S_blue                  #268bd2
    #define S_cyan                  #2aa198
    #define S_green                 #859900

    !! Dark
    !! ----
    #define S_base03                #002b36
    #define S_base02                #073642
    #define S_base01                #586e75
    #define S_base00                #657b83
    #define S_base0                 #839496
    #define S_base1                 #93a1a1
    #define S_base2                 #eee8d5
    #define S_base3                 #fdf6e3

    !! Light
    !! ----
    !#define S_base03               #fdf6e3
    !#define S_base02               #eee8d5
    !#define S_base01               #93a1a1
    !#define S_base00               #839496
    !#define S_base0                #657b83
    !#define S_base1                #586e75
    !#define S_base2                #073642
    !#define S_base3                #002b36

    URxvt*background:               S_base03
    URxvt*foreground:               S_base0
    URxvt*fading:                   40
    URxvt*fadeColor:                S_base03
    URxvt*cursorColor:              S_base1
    URxvt*pointerColorBackground:   S_base01
    URxvt*pointerColorForeground:   S_base1

    URxvt*color0:                   S_base02
    URxvt*color1:                   S_red
    URxvt*color2:                   S_green
    URxvt*color3:                   S_yellow
    URxvt*color4:                   S_blue
    URxvt*color5:                   S_magenta
    URxvt*color6:                   S_cyan
    URxvt*color7:                   S_base2
    URxvt*color9:                   S_orange
    URxvt*color8:                   S_base03
    URxvt*color10:                  S_base01
    URxvt*color11:                  S_base00
    URxvt*color12:                  S_base0
    URxvt*color13:                  S_violet
    URxvt*color14:                  S_base1
    URxvt*color15:                  S_base3

  '';

}


