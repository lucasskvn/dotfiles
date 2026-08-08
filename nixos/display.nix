{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    xkb.layout = "fr";
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /home/lucas/dotfiles/wallpapers/wallpaper.jpg
      dunst &
    '';
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
