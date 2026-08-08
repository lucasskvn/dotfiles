{ config, lib, pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --color=auto --group-directories-first";
      ll = "eza -la --icons";
      cat = "bat --paging=never";
      grep = "rg --no-heading";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      palette = "gruvbox";
      palettes.gruvbox = {
        bg0 = "#282828";
        bg1 = "#3c3836";
        fg0 = "#ebdbb2";
        red = "#fb4934";
        green = "#b8bb26";
        yellow = "#fabd2f";
        blue = "#83a598";
        purple = "#d3869b";
        aqua = "#8ec07c";
        orange = "#fe8019";
      };
      format = "$username$hostname$directory$git_branch$git_status$python$rust$nodejs$cmd_duration$line_break$status$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      username = {
        show_always = false;
        style_user = "bold aqua";
        style_root = "bold red";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold yellow) ";
      };
      directory = {
        style = "blue";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        format = "on [$symbol$branch]($style) ";
        style = "bold purple";
      };
      git_status.style = "bold yellow";
      python.style = "bold blue";
      rust.style = "bold orange";
      nodejs.style = "bold green";
      cmd_duration = {
        format = "took [$duration](bold yellow) ";
        min_time = 2000;
      };
      status = {
        disabled = false;
        format = "[$status]($style) ";
        style = "bold red";
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
