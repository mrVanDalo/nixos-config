{ config, pkgs, ... }:

let

  weatherScript = pkgs.writeShellScriptBin "weather" ''
    ${pkgs.curl}/bin/curl wttr.in/Berlin
  '';

  qrCodeScript = pkgs.writeShellScriptBin "qrCode" ''
    ${pkgs.curl}/bin/curl "qrenco.de/$1"
  '';

  cheatSheetScript  = pkgs.writeShellScriptBin "cheatsheet" ''
    ${pkgs.curl}/bin/curl "cheat.sh/$1"
  '';

in {

  environment.systemPackages = [
    weatherScript
    qrCodeScript
    cheatSheetScript
  ];

}


