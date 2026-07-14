# ⚙️ Dotfiles — Configuration de Lucas Kvn

<div align="center">
  <img src="https://img.shields.io/badge/Zsh-Yes-green?style=for-the-badge&logo=zsh&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/Neovim-Yes-green?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/OXWM-Yes-blue?style=for-the-badge&logo=linux&logoColor=white" alt="OXWM">
  <img src="https://img.shields.io/badge/Kitty-Yes-green?style=for-the-badge&logo=kitty&logoColor=white" alt="Kitty">
</div>

<br>

Mes dotfiles personnels pour un environnement de développement productif et esthétique. Configuration complète pour **Zsh**, **Neovim**, **OXWM** et **Kitty**.

---

## ✨ Fonctionnalités

- 🐚 **Zsh** — Shell configuré avec Oh My Zsh, autosuggestions et syntax highlighting
- 📝 **Neovim** — Éditeur configuré avec LSP, Treesitter et une vingtaine de plugins
- 🪟 **OXWM** — Gestionnaire de fenêtres X11 dynamique
- 🖥️ **Kitty** — Terminal GPU-accéléré avec thème Gruvbox
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
stow kitty
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

## 📁 Structure

```
dotfiles/
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
│   └── oxwm/              # Configuration OXWM
│       └── config.lua
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
- **Mason** — Gestionnaire de serveurs LSP, linters et formatters
- **nvim-cmp** — Système de complétion de code
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
stow -R zsh nvim oxwm kitty
```

---

## 👤 Auteur

**lucasskvn** — [GitHub](https://github.com/lucasskvn)

---

<div align="center">
  <sub>⚙️ Fait avec ❤️ et beaucoup de configuration</sub>
</div>
