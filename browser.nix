{ config, lib, pkgs, ... }:

let


  # desktop file
  # ------------
  # makes it possible to be used by other programs
  desktop-file = browser-name: bin: pkgs.writeTextFile {
    name        = "${browser-name}.desktop" ;
    destination = "/share/applications/${browser-name}.desktop";
    text        = ''
      [Desktop Entry]
      Type=Application
      Exec=${bin}/bin/${browser-name} %U
      Icon=chromium
      Comment=An open source web browser from Google
      Terminal=false
      Name=${browser-name}
      GenericName=Web browser
      MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/mailto;x-scheme-handler/webcal;x-scheme-handler/about;x-sc
      Categories=Network;WebBrowser
      StartupWMClass=${browser-name}
    '';
  };


  # browsers
  # --------
  # to be choosen by the createBrowser function
  google-browser   = "${pkgs.google-chrome}/bin/google-chrome-stable $@";
  chromium-browser = "${pkgs.chromium}/bin/chromium $@";
  firefox-browser  = "${pkgs.firefox}/bin/firefox $@";

  # creates a jailed browser
  # ------------------------
  createBrowser = browser-name: browser: home-folder:
    let
      bin = pkgs.writeShellScriptBin "${browser-name}" ''
        if [[ ! -d ${home-folder} ]]
        then
          mkdir -p ${home-folder}
        fi

        /var/run/wrappers/bin/firejail \
          --private=${home-folder} \
          ${browser}
      '';
    in {

      # add to browser-select
      # ---------------------
      browser.list ."${browser-name}" = bin ;

      # install
      # -------
      environment.systemPackages = [
        bin
        ( desktop-file browser-name bin )
        pkgs.firejail
      ];
    };

  createBrowserInHome = browser-name: browser:
    createBrowser browser-name browser "~/.firejail-${browser-name}";

  # browser chooser
  # ---------------
  browser-select = pkgs.writeScriptBin  "browser-select" ''

    # select a browser using dmenu
    # ----------------------------
    BROWSER=$( echo -e "${lib.concatStringsSep "\\n" browser-list}" \
      | ${pkgs.dmenu}/bin/dmenu )

    # start selected browser
    # ----------------------
    case $BROWSER in
    ${lib.concatMapStringsSep "\n" browser-case browser-list}
    esac
    $BIN "$@"
  '';
  browser-list = builtins.attrNames config.browser.list;
  browser-case  = bin: ''
    ${bin}) export BIN=${config.browser.list.${bin}}/bin/${bin}
    ;;
  '';

in {

  # selectable browsers
  # -------------------
  # is filled in the createBrowser function
  # and collected in the browser-select script
  options.browser.list = lib.mkOption {
    type = with lib.types;
    attrsOf path;
  };
  config.environment.systemPackages = [
    browser-select
    ( desktop-file browser-select.name browser-select )
  ];

  # add browser
  # -----------
  imports = [

    # top specific browser
    # --------------------
    ( createBrowserInHome "finance"     firefox-browser )
    ( createBrowserInHome "facebook"    chromium-browser )
    ( createBrowserInHome "development" chromium-browser )
    ( createBrowserInHome "hangout"     google-browser )
    ( createBrowserInHome "sononym"     chromium-browser)

    # RAM browser
    # -----------
    ( createBrowser "firefox-tmp"  firefox-browser  "/dev/shm/firefox-tmp/" )
    ( createBrowser "chromium-tmp" chromium-browser "/dev/shm/chromium-tmp/" )
    ( createBrowser "google-tmp"   google-browser   "/dev/shm/google-tmp/" )

  ];


  # set the default browser system-wide
  # -----------------------------------
  # check with : xdg-mime query default text/html
  # todo : this should be configurable by a module
  # todo : not working right now : current fix :
  #        xdg-settings set default-web-browser browser-select.desktop

  config.environment.etc."xdg/mimeapps.list".source = pkgs.writeText "mimeapps.list" ''
    [Default Applications]
    text/html=${browser-select.name}.desktop
    x-scheme-handler/http=${browser-select.name}.desktop
    x-scheme-handler/https=${browser-select.name}.desktop
    x-scheme-handler/about=${browser-select.name}.desktop
    x-scheme-handler/unknown=${browser-select.name}.desktop
  '';

}
