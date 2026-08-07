{ config, lib, pkgs, ... }:

{
  users.users.lucas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
