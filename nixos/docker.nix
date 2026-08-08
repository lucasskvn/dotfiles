{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  users.users.lucas.extraGroups = [ "docker" ];
}
