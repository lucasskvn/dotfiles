# ⚙️ Dotfiles

<div align="center">
  <img src="https://img.shields.io/badge/Zsh-Yes-green?style=for-the-badge&logo=zsh&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/Neovim-Yes-green?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/OXWM-Yes-blue?style=for-the-badge&logo=linux&logoColor=white" alt="OXWM">
  <img src="https://img.shields.io/badge/Kitty-Yes-green?style=for-the-badge&logo=kitty&logoColor=white" alt="Kitty">
  <img src="https://img.shields.io/badge/ST-Yes-orange?style=for-the-badge&logo=linux&logoColor=white" alt="ST">
  <img src="https://img.shields.io/badge/Dmenu-Yes-purple?style=for-the-badge&logo=linux&logoColor=white" alt="Dmenu">
</div>

<br>

Mes dotfiles personnels pour un environnement de développement productif et esthétique. Configuration complète pour **Zsh**, **Neovim**, **OXWM**, **Kitty**, **ST** et **Dmenu**.

---

## ✨ Fonctionnalités

- 🐚 **Zsh** — Shell configuré avec Oh My Zsh, autosuggestions et syntax highlighting
- 📝 **Neovim** — Éditeur configuré avec LSP, Treesitter et une trentaine de plugins
- 🪟 **OXWM** — Gestionnaire de fenêtres X11 dynamique avec barre d'état intégrée
- 🖥️ **Kitty** — Terminal GPU-accéléré avec thème Gruvbox
- 🪄 **ST** — Terminal suckless (simple terminal) patché
- 🚀 **Dmenu** — Lanceur d'applications suckless avec patch center et fuzzy
- 🎨 **Thèmes** — Palette cohérente Gruvbox dans tous les outils

---

## 🚀 Installation

### Prérequis

- Linux
- Git
- GNU Stow (recommandé)

### Installation avec GNU Stow

```bash
# Cloner le repository
git clone https://github.com/lucasskvn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Installer les dotfiles avec stow
stow zsh
stow nvim
stow oxwm
stow qtile
stow kitty
stow st
stow dmenu
```

### Installation manuelle

```bash
# Cloner le repository
git clone https://github.com/lucasskvn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Copier les fichiers de configuration
cp .zshrc ~/
cp -r .config/* ~/.config/
```

---

## 🖥️ NixOS

La configuration système est un **flake NixOS** (nixpkgs pinné via `flake.lock`) multi-host.

### Structure

```
flake.nix                 # Entrée du flake (nixpkgs + sops-nix, mkHost)
secrets.yaml              # Secrets chiffrés (sops) : identité git, clé SSH
hosts/
├── vm/                   # VM VirtualBox (actuelle)
│   ├── configuration.nix # hostName "VM", import hardware
│   └── hardware-configuration.nix  # Généré par nixos-generate-config
└── butterfly/            # Laptop (Intel + NVIDIA)
    ├── configuration.nix # hostName "Butterfly", microcode, NVIDIA, TLP, touchpad
    └── hardware-configuration.nix  # À générer à l'installation
nixos/                    # Modules communs partagés par tous les hosts
├── configuration.nix     # Point d'entrée : imports + allowUnfree + nix.gc
├── secrets.nix           # sops-nix : secrets + écriture configs utilisateur à l'activation
├── boot.nix              # systemd-boot
├── networking.nix        # NetworkManager
├── locale.nix            # timezone, locale fr_FR.UTF-8
├── display.nix           # X11, Qtile, clavier fr, wallpaper
├── users.nix             # Utilisateur lucas
├── programs.nix          # Firefox, Zsh
├── packages.nix          # Paquets système
├── services.nix          # OpenSSH, firewall
└── audio.nix             # PipeWire
```

### Secrets (sops-nix)

Les valeurs personnelles (identité git, clé SSH) sont chiffrées avec [sops-nix](https://github.com/Mic92/sops-nix) dans `secrets.yaml` — commité chiffré, décrypté à l'activation vers `/run/secrets`. La clé de déchiffrement est la clé age de la machine (`~/.config/sops/age/keys.txt`).

```bash
# Éditer les secrets (nécessite sops + la clé age)
sops secrets.yaml

# Régénérer une clé age si absente
age-keygen -o ~/.config/sops/age/keys.txt
```

Chaque machine a sa propre clé age. Ajouter une machine comme recipient :

```bash
age-keygen -y ~/.config/sops/age/keys.txt   # clé publique de la machine
sops updatekeys secrets.yaml                # puis ajouter la clé publique
```

### Build et switch

```bash
# Sur la VM
sudo nixos-rebuild switch --flake ~/dotfiles#vm

# Sur le laptop
sudo nixos-rebuild switch --flake ~/dotfiles#butterfly

# Build sans appliquer (validation)
nixos-rebuild build --flake ~/dotfiles#vm

# Vérification complète du flake (tous les hosts)
nix flake check ~/dotfiles
```

### Installer un nouveau host (migration VM → laptop)

#### 1. Installer NixOS (depuis l'ISO)

```bash
# Partitionner (UEFI) : p1 = EFI (512M vfat), p2 = root ext4, p3 = swap
fdisk /dev/nvme0n1
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkswap /dev/nvme0n1p3 && swapon /dev/nvme0n1p3

mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot

nixos-generate-config --root /mnt
# Écrire une config minimale dans /mnt/etc/nixos/configuration.nix
nixos-install
reboot
```

Configuration minimale pour `nixos-install` :

```nix
{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  boot.loader.systemd-boot.enable = true;
  networking.networkmanager.enable = true;
  users.users.lucas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  system.stateVersion = "26.05";
}
```

#### 2. Premier boot : réseau + outils

```bash
# Connexion wifi si nécessaire
nmcli device wifi connect <SSID> password <mot-de-passe>

# Le système frais n'a pas encore sops/age/git
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git nixpkgs#sops nixpkgs#age
```

#### 3. Cloner le repo + récupérer le hardware

```bash
git clone https://github.com/lucasskvn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Copier le hardware généré à l'installation vers le host
sudo cp /etc/nixos/hardware-configuration.nix hosts/butterfly/hardware-configuration.nix
sudo chown lucas:users hosts/butterfly/hardware-configuration.nix
```

#### 4. Clé age + secrets

```bash
# Générer la clé age du laptop (dans ~/.config/sops/age/keys.txt)
age-keygen -o ~/.config/sops/age/keys.txt
age-keygen -y ~/.config/sops/age/keys.txt   # affiche la clé publique

# Ajouter cette clé publique comme recipient dans secrets.yaml
sops updatekeys secrets.yaml
```

#### 5. Premier rebuild

```bash
sudo nixos-rebuild switch --flake ~/dotfiles#butterfly
```

Le premier switch télécharge nixpkgs et construit tout le système. L'activation écrit aussi l'identité git (`~/.config/git/config`) et la clé SSH (`~/.ssh/authorized_keys`) depuis les secrets décryptés.

#### 6. Installer les dotfiles

```bash
cd ~/dotfiles
stow zsh nvim oxwm qtile kitty st dmenu
```

#### 7. Migrer les données depuis la VM

```bash
# Depuis la VM, vers le laptop (même réseau)
rsync -avz --progress ~/Documents ~/Projets ~/.ssh lucas@<ip-laptop>:~/

# OU : sauvegarde sur disque externe, puis restauration
```

Ne **pas** copier `~/.config/git/config`, `~/.ssh/authorized_keys` ni les configs gérées par stow (générés automatiquement). Copier en revanche les clés SSH **privées** (`~/.ssh/id_ed25519`).

---

## 📁 Structure

```
dotfiles/
├── flake.nix              # Flake NixOS (multi-host)
├── secrets.yaml           # Secrets chiffrés (sops-nix)
├── hosts/                 # Un dossier par machine (vm, butterfly...)
├── nixos/                 # Modules NixOS communs
├── .zshrc                 # Configuration Zsh
├── .config/
│   ├── kitty/             # Configuration Kitty
│   │   ├── kitty.conf
│   │   └── theme.conf     # Thème Gruvbox
│   ├── nvim/              # Configuration Neovim
│   │   ├── init.lua
│   │   ├── plugins.lua
│   │   ├── lazy-lock.json
│   │   ├── lua/config/    # Configs générales
│   │   └── lua/plugins/   # Configs des plugins
│   ├── oxwm/              # Configuration OXWM
│   │   └── config.lua
│   └── qtile/             # Configuration Qtile
│       └── config.py
├── st/                    # Simple Terminal (suckless)
│   ├── config.h           # Configuration personnalisée
│   ├── config.def.h       # Configuration par défaut
│   └── ...
├── dmenu/                 # Dynamic Menu (suckless)
│   ├── config.h           # Configuration personnalisée
│   ├── config.def.h       # Configuration par défaut
│   ├── patches/           # Patches appliqués
│   └── ...
├── wallpapers/            # Fond d'écran
└── README.md
```

---

## 🐚 Zsh

### Plugins

- **zsh-autosuggestions** — Suggestions automatiques basées sur l'historique
- **zsh-syntax-highlighting** — Coloration syntaxique des commandes
- **Starship** — Prompt minimaliste et rapide

### Alias

```bash
alias banana="clang-20 -fplugin=... -fsyntax-only"  # Epitech coding style
alias banana-repo="banana-check-repo"
alias banana-docker='docker run ...'                  # Dans un conteneur
```

---

## 📝 Neovim

### Plugins principaux

- **nvim-lspconfig** — Configuration LSP (C/C++, Rust, Python, TS, Go, Lua...)
- **nvim-treesitter** — Analyse syntaxique avancée
- **Snacks.nvim** — Ensemble d'utilitaires (picker, notifier, terminal, zen...)
- **Mason** + **mason-tool-installer** — Gestionnaire de serveurs LSP, linters et formatters
- **nvim-cmp** — Système de complétion de code
- **conform.nvim** — Formatage automatique à la sauvegarde
- **gitsigns.nvim** — Indicateurs Git dans la gouttière
- **which-key.nvim** — Aide contextuelle pour les raccourcis
- **nvim-surround** — Manipulation de délimiteurs (parenthèses, guillemets...)
- **Comment.nvim** — Commentaire de code
- **render-markdown.nvim** — Rendu Markdown dans Neovim
- **Lualine** — Barre d'état
- **Harpoon** — Navigation rapide entre fichiers
- **Oil** — Gestionnaire de fichiers dans le buffer
- **Bufferline** — Onglets pour les buffers
- **Lspsaga** — UI améliorée pour le LSP
- **Telescope** — Recherche fuzzy
- **Undotree** — Visualisation de l'historique
- **Orgmode** — Prise de notes en .org

### Thèmes disponibles

Cyberdream · Oxocarbon · Dracula · Ayu · VSCode Colors · Noirblaze · Sunbather · Pinkmare · Onedark

### Raccourcis clavier

| Mode | Touche | Action |
|:-----|:-------|:-------|
| Normal | `<leader>ff` | Recherche de fichiers |
| Normal | `<leader>sg` | Grep |
| Normal | `gd` | Aller à la définition |
| Normal | `gr` | Références |
| Normal | `<leader>z` | Mode Zen |
| Normal | `<leader>gg` | Lazygit |
| Normal | `<C-/>` | Terminal |
| Normal | `<leader>uC` | Changer de thème |
| Insert | `<C-Space>` | Complétion |

---

## 🪟 OXWM

Gestionnaire de fenêtres X11 dynamique avec barre d'état intégrée.

### Raccourcis clavier

| Touche | Action |
|:-------|:-------|
| `Super + Return` | Terminal |
| `Super + D` | Dmenu |
| `Super + A` | Fermer la fenêtre |
| `Super + F` | Plein écran |
| `Super + Q` | Activer/désactiver les gaps |
| `Super + Shift + S` | Capture d'écran (Flameshot) |
| `Super + 1-9` | Changer de workspace |
| `Super + Shift + 1-9` | Déplacer la fenêtre vers un workspace |
| `Super + H/L` | Redimensionner le master |
| `Super + J/K` | Focus fenêtre suivante/précédente |
| `Super + Shift + J/K` | Déplacer la fenêtre dans la stack |

---

## 🖥️ Kitty

Terminal GPU-accéléré avec thème Gruvbox dark.

### Raccourcis

| Touche | Action |
|:-------|:-------|
| `Ctrl+Shift+F` | Clear + cd interactif |
| `Ctrl+F` | Envoyer `fg` (foreground) |

---

## 🪄 ST (Simple Terminal)

Terminal suckless (st) version 0.9.3, compilé depuis [suckless.org](https://st.suckless.org/).

### Modifications

- Police **JetBrainsMono Nerd Font** avec fallback Noto Color Emoji
- Scroll avec les touches `Shift+PageUp/PageDown` et la molette
- Raccourci `Ctrl+O` pour ouvrir l'URL sélectionnée dans Firefox
- Recherche avec `Ctrl+Shift+F`
- Copier (`Ctrl+Shift+C`) / Coller (`Ctrl+Shift+V`)
- Opacité et transparence configurées

---

## 🚀 Dmenu

Lanceur d'applications dynamique depuis [suckless.org](https://tools.suckless.org/dmenu/).

### Patches appliqués

- **center** — Centrage de dmenu à l'écran
- **fuzzy** — Matching flou pour la recherche
- **alpha** — Support de la transparence
- **highlight** — Surlignage des correspondances

### Utilisation

| Touche | Action |
|:-------|:-------|
| `Super + D` | Lancer dmenu (configuré dans OXWM) |
| `Alt+1-9` | Navigation dans les résultats |
| `Entrée` | Lancer la sélection |

---

## 🎨 Thèmes

Toutes les configurations utilisent une palette **Gruvbox dark** cohérente.

### Couleurs

```bash
background = #000000 / #1d2021
foreground = #ebdbb2
red        = #cc231c
green      = #989719
yellow     = #d79920
blue       = #448488
magenta    = #b16185
cyan       = #689d69
```

### Polices

- **JetBrainsMono Nerd Font** — 11pt (Kitty)
- **FiraCode Nerd Font** — 14pt (Neovim)

---

## 🔄 Mise à jour

```bash
cd ~/dotfiles
git pull
stow -R zsh nvim oxwm qtile kitty st dmenu
```

Sur NixOS, reconstruire le système après `git pull` :

```bash
sudo nixos-rebuild switch --flake ~/dotfiles#vm   # VM
# ou, sur le laptop :
sudo nixos-rebuild switch --flake ~/dotfiles#butterfly
```

---

## 👤 Auteur

**lucasskvn** — [GitHub](https://github.com/lucasskvn)

---

<div align="center">
  <sub>⚙️ Fait avec ❤️ et beaucoup de configuration</sub>
</div>
