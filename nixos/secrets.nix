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
    # Lisible par lucas : lu à runtime par mbsync (PassCmd) et neomutt
    mail_imap_host = { owner = "lucas"; mode = "0400"; stripTrailingNewline = true; };
    mail_imap_user = { owner = "lucas"; mode = "0400"; stripTrailingNewline = true; };
    mail_imap_pass = { owner = "lucas"; mode = "0400"; stripTrailingNewline = true; };
  };

  # Écrit les configs utilisateur depuis les secrets décryptés
  # à l'activation (/run/secrets).
  system.activationScripts.sops-home-config = lib.stringAfter [ "setupSecrets" ] ''
    mkdir -p ${home}/.config/git ${home}/.ssh ${home}/.config/isync ${home}/Mail
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
    TLSType IMAPS
    AuthMechs LOGIN
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
    ln -sfn ${home}/.config/isync/mbsyncrc ${home}/.config/isyncrc
    chown -R lucas:users ${home}/.config/git ${home}/.ssh ${home}/.config/isync ${home}/Mail
    chmod 600 ${home}/.config/git/config ${home}/.ssh/authorized_keys ${home}/.config/isync/mbsyncrc
  '';
}
