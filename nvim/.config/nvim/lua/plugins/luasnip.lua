return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    delete_check_events = "TextChanged",
  },
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
  end,
}