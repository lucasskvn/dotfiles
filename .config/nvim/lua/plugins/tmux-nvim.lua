return {
  "aserowy/tmux.nvim",
  config = function()
    require("tmux").setup({
      -- Configuration des touches de navigation
      navigation = {
        -- Active la navigation entre les fenêtres vim et les panes tmux
        enable_default_keybindings = true,
      },
      -- Configuration de redimensionnement
      resize = {
        -- Active le redimensionnement des fenêtres vim et des panes tmux
        enable_default_keybindings = true,
      },
      -- Permet de copier dans le presse-papier du système
      copy_sync = {
        enable = true,
      },
    })
  end,
}
