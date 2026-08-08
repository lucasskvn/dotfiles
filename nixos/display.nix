{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    xkb.layout = "fr";
    xkb.options = "caps:escape";
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    displayManager.sessionCommands = ''
      xwallpaper --zoom /home/lucas/dotfiles/wallpapers/wallpaper.jpg
      dunst &
      nm-applet --indicator &
      polkit-gnome-authentication-agent-1 &
    '';
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
