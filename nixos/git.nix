{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Lucas";
        email = "lucas.sangkhavongs@epitech.eu";
      };
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
