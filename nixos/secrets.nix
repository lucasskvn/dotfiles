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
    mail_imap_host = { };
    mail_imap_user = { };
    mail_imap_pass = { };
  };

  # Écrit les configs utilisateur depuis les secrets décryptés
  # à l'activation (/run/secrets).
  system.activationScripts.sops-home-config = lib.stringAfter [ "setupSecrets" ] ''
    mkdir -p ${home}/.config/git ${home}/.ssh ${home}/.config/isync
    cat > ${home}/.config/git/config <<EOF
    [user]
    name = $(cat /run/secrets/git_name)
    email = $(cat /run/secrets/git_email)
    EOF
    cat /run/secrets/ssh_authorized_key > ${home}/.ssh/authorized_keys
    cat > ${home}/.config/isync/mbsyncrc <<EOF
    IMAPAccount mail
    Host $(cat /run/secrets/mail_imap_host)
    User $(cat /run/secrets/mail_imap_user)
    PassCmd "cat /run/secrets/mail_imap_pass"
    SSLType IMAPS
    CertificateFile /etc/ssl/certs/ca-certificates.crt

    IMAPStore mail-remote
    Account mail

    MaildirStore mail-local
    Path ${home}/Mail/
    Inbox ${home}/Mail/Inbox

    Channel mail
    Far :mail-remote:
    Near :mail-local:
    Patterns *
    Create Both
    SyncState *
    EOF
    chown -R lucas:users ${home}/.config/git ${home}/.ssh ${home}/.config/isync
    chmod 600 ${home}/.config/git/config ${home}/.ssh/authorized_keys ${home}/.config/isync/mbsyncrc
  '';
}
