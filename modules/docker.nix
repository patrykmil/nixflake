{ pkgs, ... }:
{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

  programs.fish.shellInit = ''
    set -x DOCKER_HOST unix:///run/user/(id -u)/docker.sock
  '';
}
