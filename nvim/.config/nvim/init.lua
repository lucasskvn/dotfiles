-- init.lua lucasskvn
require("config.lazy")
require("config.keymaps")
require("config.epiheader")
require("config.colorscheme")
if vim.g.neovide then
  vim.opt.guifont = "FiraCode Nerd Font:h14"
end
