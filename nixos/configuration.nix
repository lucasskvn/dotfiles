{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./display.nix
    ./users.nix
    ./programs.nix
    ./packages.nix
    ./services.nix
    ./audio.nix
    ./dev.nix
    ./docker.nix
    ./nix-ld.nix
    ./git.nix
    ./fonts.nix
    ./secrets.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "lucas" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  services.earlyoom.enable = true;

  boot.tmp.useTmpfs = true;

  system.stateVersion = "26.05";
}
