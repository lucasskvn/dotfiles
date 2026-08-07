{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings.LC_ALL = "fr_FR.UTF-8";
}
