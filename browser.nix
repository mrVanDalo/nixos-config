{ config, lib, pkgs, ... }:

# browser
# -------
# Don't forget to run 'xhost +' with your user
# to make sure the browser user can write to X
let

  # browser select
  # --------------
  browser-select = pkgs.writeScriptBin "browser-select" ''
    BROWSER=$(echo -e "${lib.concatStringsSep "\\n" browser_paths }" | ${pkgs.dmenu}/bin/dmenu)
    case $BROWSER in
    ${lib.concatMapStringsSep "\n" browser_case browser_paths}
    esac
    $BIN "$@"
  '';

  browser_paths = builtins.attrNames config.browser.paths;

  browser_case = n: ''
    ${n}) export BIN=${config.browser.paths.${n}}/bin/${n}
            ;;
    '';

  # create browser
  # --------------
  createChromiumBrowser = name: groups:
    let

      bin = pkgs.writeShellScriptBin "${name}" ''
        /var/run/wrappers/bin/sudo -u ${name} -i ${pkgs.chromium}/bin/chromium $@
      '';

    in {

      users.users.${name} = {
        isNormalUser = true;
        home = "/home/${name}";
        description = "A servant who opens the browser for me";
        extraGroups = groups;
        createHome = true;
      };

      browser.paths.${name} = bin;

      security.sudo.extraConfig = ''
        palo ALL=(${name}) NOPASSWD: ALL
      '';

      environment.systemPackages = [ 
        bin 
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
  config.environment.systemPackages = [ browser-select ];

  # create all kinds of browsers  
  # ----------------------------
  imports = [
    ( createChromiumBrowser "browser" [ "audio" ] )
    ( createChromiumBrowser "browser-sononym" [ "audio" ] )
    ( createChromiumBrowser "browser-facebook" [ "audio" ] )
    ( createChromiumBrowser "browser-development" [ "audio" ] )
  ];

  


}
  
