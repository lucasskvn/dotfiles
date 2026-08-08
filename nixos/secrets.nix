{ config, lib, pkgs, ... }:

{
  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.keyFile = "/home/lucas/.config/sops/age/keys.txt";

  sops.secrets = {
    git_name = { };
    git_email = { };
    ssh_authorized_key = { };
  };

  # Écrit l'identité git et la clé SSH de l'utilisateur depuis les secrets
  # décryptés à l'activation (/run/secrets).
  system.activationScripts.sops-home-config = lib.stringAfter [ "setupSecrets" ] ''
    mkdir -p /home/lucas/.config/git /home/lucas/.ssh
    cat > /home/lucas/.config/git/config <<EOF
    [user]
    name = $(cat /run/secrets/git_name)
    email = $(cat /run/secrets/git_email)
    EOF
    cat /run/secrets/ssh_authorized_key > /home/lucas/.ssh/authorized_keys
    chown -R lucas:users /home/lucas/.config/git /home/lucas/.ssh
    chmod 600 /home/lucas/.config/git/config /home/lucas/.ssh/authorized_keys
  '';
}
