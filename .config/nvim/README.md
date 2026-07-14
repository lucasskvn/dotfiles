# Configuration NeoVim

## Introduction

Cette configuration NeoVim est personnalisée avec un ensemble de plugins soigneusement sélectionnés pour offrir une expérience d'édition puissante et efficace. Elle comprend des outils pour le développement en C, Lua, Python et Rust, ainsi que de nombreuses fonctionnalités pour améliorer la productivité.

## Structure de la configuration

La configuration est organisée de manière modulaire:

- `init.lua` : Point d'entrée de la configuration
- `plugins.lua` : Liste de tous les plugins chargés
- `lua/config/` : Contient les fichiers de configuration généraux
- `lua/plugins/` : Contient les configurations spécifiques à chaque plugin

## Plugins installés

### Éditeur et interface

- **Treesitter** : Analyse syntaxique avancée pour le code
- **Snacks** : Ensemble d'utilitaires pour Neovim
- **Mason** : Gestionnaire de serveurs LSP, linters et formatters
- **Telescope** : Recherche fuzzy pour les fichiers, buffers, etc.
- **Lualine** : Barre d'état améliorée
- **NvimTree** : Explorateur de fichiers
- **Oil** : Gestionnaire de fichiers dans le buffer
- **Harpoon** : Navigation rapide entre fichiers
- **Undotree** : Visualisation de l'historique des modifications
- **Autopairs** : Fermeture automatique des parenthèses, crochets, etc.
- **Bufferline** : Gestion des buffers avec onglets

### LSP et complétion

- **LSP Config** : Configuration des serveurs de langage
- **nvim-cmp** : Système de complétion de code
- **LuaSnip** : Système de snippets

### Thèmes

- **Cyberdream**
- **Oxocarbon**
- **Dracula**
- **Ayu-vim**
- **VSCode Colors**
- **Noirblaze**
- **Sunbather**
- **Pinkmare**

### Utilitaires spécifiques

- **Epi-quickfix** : Utilitaires pour Epitech

## Keymaps importants

### Touches générales

- `<Space>` : Touche leader
- `<ESC>` : Désactive la surbrillance de recherche
- `<leader>w` : Enregistre le fichier

### Navigation et recherche

- `<leader>ff` / `<leader>sf` : Recherche de fichiers
- `<leader>sg` : Recherche par grep
- `<leader>sb` : Recherche dans les lignes du buffer
- `<C-/>` : Ouvre un terminal

### LSP et code

- `gd` : Aller à la définition
- `gD` : Aller à la déclaration
- `gr` : Afficher les références
- `gI` : Aller à l'implémentation
- `gy` : Aller à la définition de type
- `<leader>ss` : Afficher les symboles LSP
- `<leader>sd` : Afficher les diagnostics

### Epitech

- `<C-c><C-h>` : Insérer un header Epitech
- `<C-c><C-c>` : Enregistrer et compiler
- `<leader>gb` : Aller à une ligne spécifique

### Gestion de l'interface

- `<leader>z` : Activer/désactiver le mode Zen
- `<leader>Z` : Activer/désactiver le zoom
- `<leader>bd` : Supprimer un buffer
- `<leader>N` : Actualités Neovim
- `<leader>uC` : Sélectionner un thème de couleur

### Autres

- `<leader>.` : Ouvrir un buffer temporaire
- `<leader>gg` : Ouvrir Lazygit
- `<leader>n` : Historique des notifications
- `<leader>cR` : Renommer un fichier

## Configuration de base

```lua
vim.g.mapleader = ' '
vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
```

## Thème

Le thème par défaut est `retrobox`. La configuration prend en charge plusieurs thèmes qui peuvent être facilement changés avec `<leader>uC`.

## Support des langages

Cette configuration est optimisée pour:

- C/C++ (clangd)
- Lua (lua_ls)
- Python (pyright)
- Rust (rust_analyzer)

D'autres langages peuvent être ajoutés facilement en configurant les serveurs LSP appropriés.

## Fonctionnalités spéciales

- Support pour les headers Epitech
- Intégration avec git
- Mode Zen pour une édition sans distraction
- Navigation rapide entre les fichiers avec Harpoon
- Gestion des fichiers avec Oil