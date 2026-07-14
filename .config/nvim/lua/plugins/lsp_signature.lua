return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  opts = {
    bind = true,
    floating_window = false, -- use virtual hints instead of a floating window
    hint_enable = true,
    hint_prefix = "󰏪  ",
    handler_opts = { border = "rounded" },
    toggle_key = "<M-s>", -- Alt+s to toggle signature
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
