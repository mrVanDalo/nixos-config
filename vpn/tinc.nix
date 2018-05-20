{ config, pkgs, ... }:

let
  myMeshIp   = "10.0.0.21";
  myMeshMask = "255.255.255.0";
  myMeshName = "homegrid";
in {

  networking.extraHosts = ''
    10.0.0.25 kruck
  '';

  networking.firewall.allowedTCPPorts = [ 655 ];
  networking.firewall.allowedUDPPorts = [ 655 ];

  services.tinc.networks."${myMeshName}"= {
    name          = "workhorse";
    debugLevel    = 3;
    interfaceType = "tap";
    extraConfig   = ''
      # no need for ConnectTo anymore
      AutoConnect           = yes

      # Keys
      Ed25519PrivateKeyFile = /root/secrets/workhorse/tinc/ed25519_key.priv
      PrivateKeyFile        = /root/secrets/workhorse/tinc/rsa_key.priv
    '';
    hosts = {
      workhorse = ''
        Subnet = ${myMeshIp}
        Ed25519PublicKey = sPs48jzCdtTv0Viy2Of3HlXipfxH5Y8bA+KYVkOrSiK
        -----BEGIN RSA PUBLIC KEY-----
        MIICCgKCAgEA01HJ49zxmnixWC9YMP0c3UFxZc4Hl5UK9nJvhMRBOuxm75kpzZsz
        3v6mSy1YrVE9rrGXYjZ76wKrRhchMpvrMKKD8/DRjVqTkuFwtGgUEigzpSFoSLtC
        u2Wis7Z6GW3nLgAS79NU9IUUEoeevND1zzglDb0HdERuiImiZVg3I+VXLyA31X3L
        Z/B7T4QLmZGIRvFw0y1TawMjFMJZmDBtzMqfO7behkms2O1ORAciGhGxmZ9gd7yk
        n/NKCpSSzeC6sJ28i33LRrWF3hRUXAEJFgq8YRxm6mjRoPLsJVsw2S98DvTcxmjN
        eyVnqPVQi7JuKrOQsewQvwV2KiqI9ibEYH1zZNXwy+l05b3QSaAcyRtDpwRW7FCY
        H4B3S0vjte75D4bEuYTFgT3wCzlAjdB7fPZ4jyZXdrP8G3IfbMmgsdECz5uIMwam
        UaSZISlHkSJv+erA8TMJLBnqAO7ERKYI7PRIDdIun0VtX2QjRJpWIdVpxEcL4fZU
        w6gzX8lOQe5NnoH/MFUfU0LyBuUH1k6WX7xdwrynUVS087vwaQN+H/VTp0QSX6PQ
        oCLYPCGKS2B/St954uaPanzeG7QZQpWbvttaFVmUSkilx78xqqu3zDm9pSofFKCX
        08TGlluy8JAwUqAxekQVKey2PdLmKjlMCcoUeNYbJybGplc9gv2hYhsCAwEAAQ==
        -----END RSA PUBLIC KEY-----
        '';
      kruck = ''
        Address = kruck.chickenkiller.com
        Address = 192.168.178.25
        Subnet  = 10.0.0.25

        Ed25519PublicKey = orgqHQaRoJR3YyZKUUI8ZfZo7+Rs88Lgo9D26cM8jPM
        -----BEGIN RSA PUBLIC KEY-----
        MIICCgKCAgEAxcui2sirT5YY9HrSauj9nSF3AxUnfd2CCEGyzmzbi5+qw8T9jdNh
        QcIG3s+eC3uEy6leL/eeR4NjVtQRt8CDmhGul95Vs3I1jx9gdvYR+HOatPgK0YQA
        EFwk0jv8Z8tOc87X1qwA00Gb+25+kAzsf+8+4HQuh/szSGje3RBmBFkUyNHh8R0U
        uzs8NSTRdN+edvYtzjnYcE1sq59HFBPkVcJNp5I3qYTp6m9SxGHMvsq6vRpNnjq/
        /RZVBhnPDBlgxia/aVfVQKeEOHZV3svLvsJzGDrUWsJCEvF0YwW4bvohY19myTNR
        9lXo/VFx86qAkY09il2OloE7iu5cA2RV+FWwLeajE9vIDA06AD7nECVgthNoZd1s
        qsDfuu3WqlpyBmr6XhRkYOFFE4xVLrZ0vItGYlgR2UPp9TjHrzfsedoyJoJAbhMH
        gDlFgiHlAy1fhG1sCX5883XmSjWn0eJwmZ2O9sZNBP5dxfGUXg/x8NWfQj7E1lqj
        jQ59UC6yiz7bFtObKvpdn1D4tPbqBvndZzn19U/3wKo+cCBRjtLmUD7HQHC65dCs
        fAiCFvUTVMM3SNDvYChm0U/KGjZZFwQ+cCLj1JNVPet2C+CJ0qI2muXOnCuv/0o5
        TBZrrHMpj6Th8AiOgeMVuxzjX1FsmAThWj9Qp/jQu6O0qvnkUNaU7I8CAwEAAQ==
        -----END RSA PUBLIC KEY-----
      '';
    };
  };
  environment.etc."tinc/${myMeshName}/tinc-up".source = pkgs.writeScript "tinc-up-${myMeshName}" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.nettools}/bin/ifconfig $INTERFACE ${myMeshIp} netmask ${myMeshMask}
  '';
  environment.etc."tinc/${myMeshName}/tinc-down".source = pkgs.writeScript "tinc-down-${myMeshName}" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.nettools}/bin/ifconfig $INTERFACE down
  '';

}

