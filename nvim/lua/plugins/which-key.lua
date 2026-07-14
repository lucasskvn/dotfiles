return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>c", group = "code" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "harpoon" },
      { "<leader>l", group = "lsp" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "toggle/file" },
      { "<leader>u", group = "ui" },
    },
  },
}
