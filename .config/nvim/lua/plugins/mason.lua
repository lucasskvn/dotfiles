return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "clangd",
      "lua-language-server",
      "stylua",
      "codelldb",
      "rust-analyzer",
      "pyright",
      "bash-language-server",
      "typescript-language-server",
      "html-lsp",
      "css-lsp",
      "json-lsp",
      "yaml-language-server",
      "gopls",
      "marksman",
      "taplo",
    },
  },
}