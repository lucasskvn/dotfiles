{ config, lib, pkgs, ... }:

{
  # Le hardware-configuration.nix est généré à l'installation par
  # nixos-generate-config — import conditionnel pour que le flake
  # évalue avant même l'installation du laptop.
  imports = lib.optional (builtins.pathExists ./hardware-configuration.nix)
    ./hardware-configuration.nix;

  networking.hostName = "Butterfly";

  # Placeholder pour que le flake évalue avant installation — le
  # hardware-configuration.nix généré par nixos-generate-config
  # écrase ces valeurs (mkDefault = priorité basse).
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  hardware.cpu.intel.updateMicrocode = true;

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.tlp.enable = true;
  services.libinput.enable = true;
  services.fstrim.enable = true;
  services.upower.enable = true;
  services.logind.lidSwitch = "suspend";
  services.redshift = {
    enable = true;
    latitude = "48.86";
    longitude = "2.35";
  };

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
