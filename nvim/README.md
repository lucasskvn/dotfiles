# Configuration NeoVim

## Prérequis

### Obligatoires
- **Neovim** >= 0.9
- **git** (pour le bootstrap de lazy.nvim)

### Recommandés
- **Nerd Font** (JetBrainsMono, FiraCode, etc.) — pour les icônes dans bufferline, lualine, nvim-tree, render-markdown
- **Node.js** — requis par les LSP servers installés via Mason (typescript-language-server, bash-language-server, etc.)
- **make + gcc** — pour compiler LuaSnip jsregexp et les parsers treesitter
- **ripgrep** (`rg`) — pour Snacks grep
- **lazygit** (optionnel) — pour `<leader>gg`

### Installation

```bash
git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
```

Au premier lancement, lazy.nvim s'auto-installe, puis tous les plugins sont chargés. Mason installe automatiquement les LSP servers listés dans `lua/plugins/mason.lua`.

## Structure

- `init.lua` — Point d'entrée
- `lua/config/` — Configuration générale (keymaps, colorscheme, lazy bootstrap, epiheader, codingstyle)
- `lua/plugins/` — Un fichier par plugin (auto-découvert par lazy.nvim via `{ import = "plugins" }`)

## Plugins

### Éditeur et interface
- **Treesitter** — Analyse syntaxique avancée
- **Snacks** — Utilitaires (picker, notifier, zen, terminal, etc.)
- **Mason** + **mason-tool-installer** — Gestionnaire et auto-installation des LSP servers
- **Telescope** — Recherche fuzzy
- **Lualine** — Barre d'état
- **NvimTree** — Explorateur de fichiers
- **Oil** — Gestionnaire de fichiers dans le buffer
- **Harpoon** — Navigation rapide entre fichiers
- **Undotree** — Historique des modifications
- **Autopairs** — Fermeture automatique des paires
- **Bufferline** — Onglets de buffers
- **render-markdown** — Rendu visuel Markdown

### LSP et complétion
- **LSP Config** — Configuration des serveurs de langage
- **nvim-cmp** — Complétion de code
- **LuaSnip** — Snippets
- **hover.nvim** — Hover enrichi (LSP + man + dictionnaire)
- **lspsaga** — UI LSP (finder, code actions, outline, etc.)
- **lsp_signature** — Signature de fonction en hint

### Thèmes
- Cyberdream, Oxocarbon (défaut), Dracula, Ayu-vim, VSCode Colors, Noirblaze, Sunbather, Pinkmare

### Utilitaires Epitech
- **EpiHeader** — `<C-c><C-h>` insère un header Epitech
- **Epi-quickfix** — Intégration coding-style dans la quickfixlist
- **CSquickfix** — Commande `:CSquickfix` (nécessite le binaire `coding-style`)

## Keymaps

| Touche | Action |
|--------|--------|
| `<Space>` | Leader |
| `<leader>w` | Sauvegarder |
| `<leader>ff` / `<leader>sf` | Recherche fichiers |
| `<leader>sg` | Grep |
| `<leader>gg` | Lazygit (si installé) |
| `<leader>z` | Mode Zen |
| `<leader>Z` | Zoom |
| `<leader>t` | Oil (explorateur) |
| `<leader>u` | Undotree |
| `<leader>h` | Menu Harpoon |
| `<leader>a` | Ajouter fichier Harpoon |
| `<leader>uC` | Changer colorscheme |
| `<C-/>` | Terminal |
| `gd` / `gr` / `gI` / `gy` | LSP (def, refs, impl, type) |
| `<leader>lf` / `<leader>la` / `<leader>lr` | Lspsaga (finder, code action, rename) |
| `<Tab>` / `<S-Tab>` | Buffer suivant / précédent |
| `<leader>&` à `<leader>à` | Aller au buffer 1-9 / dernier |
| `<leader>bd` | Supprimer buffer |
| `<leader>bp` | Pin/Unpin buffer |

## Thème

Oxocarbon par défaut, avec fallback automatique sur habamax en cas d'échec. Changer avec `<leader>uC`.
