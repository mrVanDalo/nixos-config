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

  # can't use bash aliases because programms will not pic it up
  de_espeak = pkgs.writeShellScriptBin "de-speak" ''
    exec ${pkgs.espeak}/bin/espeak \
      -v german \
      -s 143 \
      -p 20 \
      $@
  '';
in {


  environment.systemPackages = with pkgs ; [
    espeak
    en_espeak
    de_espeak
  ];

}

