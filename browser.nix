{ config, lib, pkgs, ... }:

# browser
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  # browser select
  # --------------
  browser-select = pkgs.writeScriptBin "browser-select" chrome-select-text;
  browser_paths = chrome-paths;
  browser_case = chrome-case;

  # chrome
  # ------
  chrome-select = pkgs.writeScriptBin "chrome-select" chrome-select-text;
  chrome-select-text = ''
    BROWSER=$(echo -e "${lib.concatStringsSep "\\n" chrome-paths}" | ${pkgs.dmenu}/bin/dmenu)
    case $BROWSER in
    ${lib.concatMapStringsSep "\n" chrome-case chrome-paths}
    esac
    $BIN "$@"
  '';
  chrome-paths = builtins.attrNames config.chrome.paths;
  chrome-case = n: ''
    ${n}) export BIN=${config.chrome.paths.${n}}/bin/${n}
            ;;
    '';
  
  # firefox
  # -------
  firefox-select = pkgs.writeScriptBin "firefox-select" firefox-select-text;
  firefox-select-text = ''
    BROWSER=$(echo -e "${lib.concatStringsSep "\\n" firefox-paths}" | ${pkgs.dmenu}/bin/dmenu)
    case $BROWSER in
    ${lib.concatMapStringsSep "\n" firefox-case firefox-paths}
    esac
    $BIN "$@"
  '';
  firefox-paths = builtins.attrNames config.firefox.paths;
  firefox-case = n: ''
    ${n}) export BIN=${config.firefox.paths.${n}}/bin/${n}
            ;;
    '';

  # create browser
  # --------------
  createChromiumBrowser = name: groups:
    let

      chrome-bin = pkgs.writeShellScriptBin "chrome-${name}" ''
        /var/run/wrappers/bin/sudo -u browser-${name} -i ${pkgs.chromium}/bin/chromium $@
      '';
      firefox-bin = pkgs.writeShellScriptBin "firefox-${name}" ''
        /var/run/wrappers/bin/sudo -u browser-${name} -i ${pkgs.firefox}/bin/firefox $@
      '';

    in {

      users.users."browser-${name}" = {
        isNormalUser = true;
        home = "/home/browser-${name}";
        description = "A servant who opens the browser for me";
        extraGroups = groups;
        createHome = true;
      };

      chrome.paths."chrome-${name}" = chrome-bin;
      firefox.paths."firefox-${name}" = firefox-bin;

      security.sudo.extraConfig = ''
        palo ALL=(browser-${name}) NOPASSWD: ALL
      '';

      environment.systemPackages = [ 
        chrome-bin 
        firefox-bin 
        pkgs.xorg.xhost 
      ];

    };

in {

  # setup browser-select
  # --------------------
  options.browser.paths = lib.mkOption { 
    type = with lib.types; 
    attrsOf path; 
  };
  options.firefox.paths = lib.mkOption { 
    type = with lib.types; 
    attrsOf path; 
  };
  options.chrome.paths = lib.mkOption { 
    type = with lib.types; 
    attrsOf path; 
  };
  config.environment.systemPackages = [ 
    browser-select
    chrome-select
    firefox-select
  ];

  # create all kinds of browsers  
  # ----------------------------
  imports = [
    ( createChromiumBrowser "sononym"     [ "audio" ] )
    ( createChromiumBrowser "facebook"    [ "audio" ] )
    ( createChromiumBrowser "development" [ "audio" ] )
    ( createChromiumBrowser "tmp"         [ "audio" ] )
    ( createChromiumBrowser "hangout"     [ "audio" "video" ] )
  ];

  


}
  
