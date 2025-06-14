return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  opts = {
    ensure_installed = {
      "clangd",
      "lua-language-server",
      "stylua",
      "codelldb",
    },
  },
}