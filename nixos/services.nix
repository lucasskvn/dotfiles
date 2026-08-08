{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  users.users.lucas.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyGFKIZ7Wpxy8/QCf3CthQEUwMm8t9n7mrCJ7D05q0L vm-nixos"
  ];

  networking.firewall.allowedTCPPorts = [ 22 ];
}
