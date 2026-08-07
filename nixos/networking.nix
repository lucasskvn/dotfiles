{ config, lib, pkgs, ... }:

{
  networking.hostName = "Butterfly";
  networking.networkmanager.enable = true;
}
