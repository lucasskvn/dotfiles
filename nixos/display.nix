{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    xkb.layout = "fr";
    displayManager.sessionCommands = ''
      xwallpaper --zoom /home/lucas/dotfiles/wallpapers/wallpaper.jpg
      xset r rate 200 35 &
    '';
  };
}
