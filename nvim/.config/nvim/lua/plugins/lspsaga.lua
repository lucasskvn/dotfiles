return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  cmd = "Lspsaga",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    ui = {
      border = "rounded",
    },
    lightbulb = {
      enable = true,
      sign = false,
      virtual_text = true,
    },
    symbol_in_winbar = { enable = false },
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
    -- keymaps moved to config/keymaps.lua
  end,
}
