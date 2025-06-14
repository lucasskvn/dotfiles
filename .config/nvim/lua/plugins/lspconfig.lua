return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- C/C++
    lspconfig.clangd.setup({})

    -- Rust
    lspconfig.rust_analyzer.setup({})

    -- Python
    lspconfig.pyright.setup({})
  end,
}