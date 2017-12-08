{ config, pkgs, ... }:

let

  # can't use bash aliases because programms will not pic it up
  en_espeak = pkgs.writeShellScriptBin "en-speak" ''
    exec ${pkgs.espeak}/bin/espeak \
      -v english \
      -s 145 \
      -p 23 \
      $@
  '';

  # read from copyq
  en_read = pkgs.writeShellScriptBin "en-read" ''
    exec ${pkgs.copyq}/bin/copyq read 0 | ${en_espeak}/bin/en-speak
  '';

  # can't use bash aliases because programms will not pic it up
  de_espeak = pkgs.writeShellScriptBin "de-speak" ''
    exec ${pkgs.espeak}/bin/espeak \
      -v german \
      -s 143 \
      -p 20 \
      $@
  '';

  # read from copyq
  de_read = pkgs.writeShellScriptBin "de-read" ''
    exec ${pkgs.copyq}/bin/copyq read 0 | ${de_espeak}/bin/de-speak
  '';

in {

  environment.systemPackages = with pkgs ; [
    espeak
    en_espeak
    en_read
    de_espeak
    de_read
  ];

}


