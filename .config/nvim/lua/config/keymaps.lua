vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.have_nerd_font = false

vim.keymap.set('n', '<C-c><C-h>', ':EpiHeader<CR>')
vim.keymap.set('n', '<C-c><C-c>', ':w <bar> Compile<CR>')
vim.keymap.set('n', '<leader>gb', ':GotoLine<CR>')
vim.keymap.set('n', '<esc><esc>', ':noh<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Snacks keymaps
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = "Files" })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = "Files" })
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set('n', '<leader>sc', function() Snacks.pickesr.command_history() end, { desc = "Command History" })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = "Undo History" })
vim.keymap.set('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Other
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set('n', '<leader>S', function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = "Rename File" })
vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = "Toggle Terminal" })
vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = "which_key_ignore" })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set('n', '<leader>N', function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    -- ajoute d'autres options si besoin
  })
end, { desc = "Neovim News" })-- Snacks keymaps
vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = "Undo History" })
vim.keymap.set('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Other
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set('n', '<leader>.', function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set('n', '<leader>S', function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = "Rename File" })
vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = "Toggle Terminal" })
vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = "which_key_ignore" })
vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- Nvim-tree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle Nvim Tree" })

-- Map les touches spéciales (&, é, ", ', (, -, è, _, ç, à) aux chiffres (1-0)
local special_to_digit = {
  ["&"] = "1",
  ["é"] = "2",
  ['"'] = "3",
  ["'"] = "4",
  ["("] = "5",
  ["-"] = "6",
  ["è"] = "7",
  ["_"] = "8",
  ["ç"] = "9",
  ["à"] = "0",
}

for special, digit in pairs(special_to_digit) do
  vim.keymap.set("n", special, digit, { noremap = true, silent = true, desc = "Type "..digit })
end

-- Map les chiffres (1-0) aux touches spéciales (&, é, ", ', (, -, è, _, ç, à)
local digit_to_special = {
  ["1"] = "&",
  ["2"] = "é",
  ["3"] = '"',
  ["4"] = "'",
  ["5"] = "(",
  ["6"] = "-",
  ["7"] = "è",
  ["8"] = "_",
  ["9"] = "ç",
  ["0"] = "à",
}

for digit, special in pairs(digit_to_special) do
  vim.keymap.set("n", digit, special, { noremap = true, silent = true, desc = "Type "..special })
end

-- Harpoon
vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end, { desc = "Harpoon Add File" })
vim.keymap.set("n", "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon Menu" })
vim.keymap.set("n", "<leader>&", function() require("harpoon.ui").nav_file(1) end, { desc = "Harpoon to File 1" })
vim.keymap.set("n", "<leader>é", function() require("harpoon.ui").nav_file(2) end, { desc = "Harpoon to File 2" })
vim.keymap.set("n", "<leader>\"", function() require("harpoon.ui").nav_file(3) end, { desc = "Harpoon to File 3" })
vim.keymap.set("n", "<leader>'", function() require("harpoon.ui").nav_file(4) end, { desc = "Harpoon to File 4" })

-- Undotree

vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = "Toggle Undotree" })
vim.keymap.set('n', '<leader>U', '<cmd>UndotreeFocus<CR>', { desc = "Focus Undotree" })
