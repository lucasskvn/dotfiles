{ config, lib, pkgs, ... }:
let
  home = config.users.users.lucas.home;
in
{
  programs.git = {
    enable = true;
    config = {
      core.excludesFile = "${home}/.config/git/ignore";
      init.defaultBranch = "main";
      pull.rebase = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        side-by-side = true;
      };
    };
  };
}
