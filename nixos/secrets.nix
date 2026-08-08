{ config, lib, pkgs, ... }:
let
  home = config.users.users.lucas.home;
in
{
  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.keyFile = "${home}/.config/sops/age/keys.txt";

  sops.secrets = {
    git_name = { };
    git_email = { };
    ssh_authorized_key = { };
  };

  # Écrit l'identité git et la clé SSH de l'utilisateur depuis les secrets
  # décryptés à l'activation (/run/secrets).
  system.activationScripts.sops-home-config = lib.stringAfter [ "setupSecrets" ] ''
    mkdir -p ${home}/.config/git ${home}/.ssh
    cat > ${home}/.config/git/config <<EOF
    [user]
    name = $(cat /run/secrets/git_name)
    email = $(cat /run/secrets/git_email)
    EOF
    cat /run/secrets/ssh_authorized_key > ${home}/.ssh/authorized_keys
    chown -R lucas:users ${home}/.config/git ${home}/.ssh
    chmod 600 ${home}/.config/git/config ${home}/.ssh/authorized_keys
  '';
}
