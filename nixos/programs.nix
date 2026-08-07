{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
}
