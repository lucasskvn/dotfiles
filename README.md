# ⚙️ Dotfiles — Configuration de Lucas Kvn

<div align="center">
  <img src="https://img.shields.io/badge/Zsh-Yes-green?style=for-the-badge&logo=zsh&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/NixOS-Yes-blue?style=for-the-badge&logo=nixos&logoColor=white" alt="NixOS">
  <img src="https://img.shields.io/badge/Neovim-Yes-green?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim">
</div>

<br>

Mes dotfiles personnels pour un environnement de développement productif et esthétique. Configuration complète pour **Zsh**, **Neovim**, **Hyprland** et bien plus.

---

## ✨ Fonctionnalités

- 🐚 **Zsh** — Shell configuré avec Oh My Zsh et plugins
- 📝 **Neovim** — Éditeur configuré avec LSP et plugins
- 🖥️ **Hyprland** — Environnement de bureau Wayland
- 🎨 **Thèmes** — Thèmes cohérents pour tous les outils
- 🔧 **Alias** — Raccourcis pour les commandes fréquentes
- 📦 **Scripts** — Scripts utilitaires pour le quotidien

---

## 🚀 Installation

### Prérequis

- Linux (NixOS recommandé)
- Git

### Installation avec GNU Stow

```bash
# Cloner le repository
git clone https://github.com/lucasskvn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Installer les dotfiles avec stow
stow zsh
stow nvim
stow hyprland
stow kitty
stow waybar
```

### Installation manuelle

```bash
# Cloner le repository
git clone https://github.com/lucasskvn/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Copier les fichiers de configuration
cp .zshrc ~/
cp -r .config ~/
```

---

## 📁 Structure

```
dotfiles/
├── .zshrc                 # Configuration Zsh
├── .config/
│   ├── nvim/              # Configuration Neovim
│   │   ├── init.lua
│   │   ├── lua/
│   │   └── plugin/
│   ├── hyprland/          # Configuration Hyprland
│   │   ├── hyprland.conf
│   │   └── monitors.conf
│   ├── kitty/             # Configuration Kitty
│   │   └── kitty.conf
│   ├── waybar/            # Configuration Waybar
│   │   └── config
│   └── ...
└── README.md
```

---

## 🐚 Zsh

### Plugins installés

- **zsh-autosuggestions** — Suggestions automatiques
- **zsh-syntax-highlighting** — Coloration syntaxique
- **zsh-completions** — Complétions supplémentaires
- **zsh-history-substring-search** — Recherche dans l'historique

### Alias utiles

```bash
# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias la="ls -A"

# Git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
```

---

## 📝 Neovim

### Plugins principaux

- **nvim-lspconfig** — Configuration LSP
- **nvim-treesitter** — Highlighting syntaxique
- **telescope.nvim** — Fuzzy finder
- **nvim-cmp** — Complétion
- **gitsigns.nvim** — Intégration Git
- **lualine.nvim** — Barre de statut

### Raccourcis clavier

| Mode | Touche | Action |
|:-----|:-------|:-------|
| Normal | `<leader>ff` | Fichier |
| Normal | `<leader>fg` | Grep |
| Normal | `<leader>fb` | Buffers |
| Normal | `<leader>fh` | Aide |
| Insert | `jk` | Échap |

---

## 🖥️ Hyprland

### Raccourcis clavier

| Touche | Action |
|:-------|:-------|
| `Super + Return` | Terminal |
| `Super + D` | Launcher |
| `Super + Q` | Fermer la fenêtre |
| `Super + F` | Plein écran |
| `Super + 1-9` | Changer de workspace |

---

## 🎨 Thèmes

### Couleurs

```bash
# Couleurs du terminal
background = #1e1e2e
foreground = #cdd6f4
cursor = #f5e0dc
selection_background = #45475a
```

### Polices

```bash
# Police principale
font_family = JetBrains Mono
font_size = 12
```

---

## 🔄 Mise à jour

```bash
# Mettre à jour les dotfiles
cd ~/dotfiles
git pull

# Réinstaller avec stow
stow -R zsh nvim hyprland kitty waybar
```

---

## 📝 Notes

- Les dotfiles sont conçus pour **NixOS** mais fonctionnent sur d'autres distributions Linux
- Pensez à adapter les chemins selon votre système
- Les configurations sont modulaires — installez seulement ce dont vous avez besoin

---

## 👤 Auteur

**Lucas Kvn** — [GitHub](https://github.com/lucasskvn) — [lucasskvn.fr](https://lucasskvn.fr)

---

<div align="center">
  <sub>⚙️ Fait avec ❤️ et beaucoup de configuration</sub>
</div>
