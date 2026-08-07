{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tree
    vim
    wget
    neovim
    zathura
    kitty
    btop
    xwallpaper
    pcmanfm
    rofi
    git
    pfetch
    stow
    gnumake
    opencode
    fastfetch
    rsync
    mpv
    vlc
    fzf
    flameshot
    pass
    neomutt
    isync
    unzip
    curl
    zed-editor
  ];
}
