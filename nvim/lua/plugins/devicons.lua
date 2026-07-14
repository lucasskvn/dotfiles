return {
  "nvim-tree/nvim-web-devicons",
  -- Load on demand; many plugins declare it as a dependency already
  lazy = true,
  opts = {
    -- Enable default icons and colors
    default = true,
    color_icons = true,
    strict = true,
    -- You can add custom overrides here later
    -- override_by_extension = { md = { icon = "", name = "Markdown", color = "#519aba" } },
  },
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)
  end,
}
