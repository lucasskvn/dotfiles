return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- enable treesitter integration
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}