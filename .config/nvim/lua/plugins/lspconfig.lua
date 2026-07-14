return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    -- Lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- C/C++
    lspconfig.clangd.setup({ capabilities = capabilities })

    -- Rust
    lspconfig.rust_analyzer.setup({ capabilities = capabilities })

    -- Python
    lspconfig.pyright.setup({ capabilities = capabilities })

    -- Bash
    lspconfig.bashls.setup({ capabilities = capabilities })

    -- TypeScript/JavaScript (tsserver)
    lspconfig.tsserver.setup({ capabilities = capabilities })

    -- HTML/CSS/JSON/YAML
    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.jsonls.setup({ capabilities = capabilities })
    lspconfig.yamlls.setup({ capabilities = capabilities })

    -- Go
    lspconfig.gopls.setup({ capabilities = capabilities })

    -- Markdown
    lspconfig.marksman.setup({ capabilities = capabilities })

    -- TOML
    lspconfig.taplo.setup({ capabilities = capabilities })
  end,
}