{ config, pkgs, ... }:

{

  virtualisation = {
    docker.enable = true;
  };

  environment.systemPackages  = with pkgs ; [
    docker
    # minikube
    # docker-machine
    # docker-machine-kvm
  ];
}

