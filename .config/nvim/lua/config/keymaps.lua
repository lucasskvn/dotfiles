vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.have_nerd_font = false
vim.opt.number = true         -- Affiche le numéro absolu sur la ligne courante
vim.opt.relativenumber = true -- Affiche les numéros relatifs ailleurs

vim.keymap.set('n', '<C-c><C-h>', ':EpiHeader<CR>')
vim.keymap.set('n', '<C-c><C-c>', ':w <bar> Compile<CR>')
vim.keymap.set('n', '<leader>gb', ':GotoLine<CR>')
vim.keymap.set('n', '<esc>', ':noh<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Helper: Symbols picker with smarter fallbacks (checks LSP results first)
local function pick_buffer_symbols()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  -- Helper to open Treesitter picker safely
  local function open_ts()
    local ok_tb, tb = pcall(require, 'telescope.builtin')
    if ok_tb and tb then
      local ok = pcall(tb.treesitter)
      if not ok then
        vim.notify("No symbols provider found (LSP/TS)", vim.log.levels.WARN)
      end
    else
      vim.notify("Telescope not available for symbols", vim.log.levels.WARN)
    end
  end

  -- If no LSP clients, try TS right away
  if not clients or #clients == 0 then
    return open_ts()
  end

  -- Check if any client supports document symbols
  local supports = false
  for _, c in ipairs(clients) do
    local caps = c.server_capabilities or {}
    if caps.documentSymbolProvider then supports = true; break end
  end
  if not supports then
    return open_ts()
  end

  -- Ask LSP for document symbols; if empty, fallback to TS
  local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
  vim.lsp.buf_request_all(bufnr, 'textDocument/documentSymbol', params, function(results)
    local has_any = false
    for _, res in pairs(results or {}) do
      local r = res and res.result
      if type(r) == 'table' and next(r) ~= nil then
        has_any = true
        break
      end
    end
    if has_any then
      -- Use Snacks picker for LSP symbols
      pcall(function() Snacks.picker.lsp_symbols() end)
    else
      open_ts()
    end
  end)
end

-- Snacks keymaps
vim.keymap.set('n', '<leader>sf', function() Snacks.picker.files() end, { desc = "Files" })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = "Files" })
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
vim.keymap.set('n', '<leader>sM', function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set('n', '<leader>sm', function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = "Undo History" })
vim.keymap.set('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- Snacks toggles (moved from plugin config)
vim.keymap.set("n", "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }):toggle() end, { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end, { desc = "Toggle Wrap" })
vim.keymap.set("n", "<leader>uL", function() Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle() end, { desc = "Toggle Relative Number" })
vim.keymap.set("n", "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, { desc = "Toggle Diagnostics" })
vim.keymap.set("n", "<leader>ul", function() Snacks.toggle.line_number():toggle() end, { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>uc", function() Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):toggle() end, { desc = "Toggle Conceal" })
vim.keymap.set("n", "<leader>uT", function() Snacks.toggle.treesitter():toggle() end, { desc = "Toggle Treesitter" })
vim.keymap.set("n", "<leader>ub", function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end, { desc = "Toggle Background" })
vim.keymap.set("n", "<leader>uh", function() Snacks.toggle.inlay_hints():toggle() end, { desc = "Toggle Inlay Hints" })
vim.keymap.set("n", "<leader>ug", function() Snacks.toggle.indent():toggle() end, { desc = "Toggle Indent Guides" })
vim.keymap.set("n", "<leader>uD", function() Snacks.toggle.dim():toggle() end, { desc = "Toggle Dim" })

-- LSP
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set('n', '<leader>ss', pick_buffer_symbols, { desc = "Symbols (LSP/TS)" })
vim.keymap.set('n', '<leader>sS', function()
  -- Workspace symbols with fallback to Telescope dynamic workspace symbols
  local ok = pcall(function() Snacks.picker.lsp_workspace_symbols() end)
  if not ok then
    local ok_tb, tb = pcall(require, 'telescope.builtin')
    if ok_tb and tb then pcall(tb.lsp_dynamic_workspace_symbols) end
  end
end, { desc = "LSP Workspace Symbols" })

-- hover.nvim extra key
vim.keymap.set("n", "gK", function()
  local ok, hover = pcall(require, "hover")
  if ok then hover.hover_select() end
end, { desc = "Hover (Select Provider)" })

-- Extra LSP UX (buffer-local on LspAttach)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspKeymaps', { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local function bufmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    -- Use hover.nvim for richer hover info (LSP + fallbacks)
    bufmap('n', 'K', function()
      local ok, hover = pcall(require, 'hover')
      if ok then hover.hover() else vim.lsp.buf.hover() end
    end, 'Hover (LSP + extras)')
    bufmap('n', 'gl', vim.diagnostic.open_float, 'Line Diagnostics')
    bufmap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  end,
})

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
vim.keymap.set({ 'n', 't' }, ']r', function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set({ 'n', 't' }, '[r', function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
vim.keymap.set('n', ']', '}', { noremap = true, silent = true, desc = "Next Paragraph" })
vim.keymap.set('n', '[', '{', { noremap = true, silent = true, desc = "Prev Paragraph" })
vim.keymap.set('n', '<leader>N', function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    -- ajoute d'autres options si besoin
  })
end, { desc = "Neovim News" })

-- Nvim-tree
vim.keymap.set('n', '<leader>t', ':Oil<CR>', { noremap = true, silent = true, desc = "Toggle Nvim Tree" })

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

-- Bufferline
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin<CR>', { desc = "Pin/Unpin Buffer" })
vim.keymap.set('n', '<leader>bP', ':BufferLineGroupClose ungrouped<CR>', { desc = "Delete Non-Pinned Buffers" })
vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { desc = "Delete Other Buffers" })
vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { desc = "Delete Buffers to the Right" })
vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { desc = "Delete Buffers to the Left" })
vim.keymap.set('n', '<leader>&', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = "Go to Buffer 1" })
vim.keymap.set('n', '<leader>é', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = "Go to Buffer 2" })
vim.keymap.set('n', '<leader>"', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = "Go to Buffer 3" })
vim.keymap.set('n', "<leader>'", '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = "Go to Buffer 4" })
vim.keymap.set('n', '<leader>(', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = "Go to Buffer 5" })
vim.keymap.set('n', '<leader>-', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = "Go to Buffer 6" })
vim.keymap.set('n', '<leader>è', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = "Go to Buffer 7" })
vim.keymap.set('n', '<leader>_', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = "Go to Buffer 8" })
vim.keymap.set('n', '<leader>ç', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = "Go to Buffer 9" })
vim.keymap.set('n', '<leader>à', '<Cmd>BufferLineGoToBuffer -1<CR>', { desc = "Go to Last Buffer" })
vim.keymap.set('n', '<leader>bs', ':BufferLinePick<CR>', { desc = "Pick Buffer" })
vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = "Pick Buffer to Close" })
vim.keymap.set('n', '<leader>bx', ':BufferLineCloseTab<CR>', { desc = "Close Current Buffer" })
vim.keymap.set('n', '<leader>bmh', ':BufferLineMoveNext<CR>', { desc = "Move Buffer Right" })
vim.keymap.set('n', '<leader>bml', ':BufferLineMovePrev<CR>', { desc = "Move Buffer Left" })
vim.keymap.set('n', '<leader>be', ':BufferLineSortByExtension<CR>', { desc = "Sort Buffers by Extension" })
vim.keymap.set('n', '<leader>bd', ':BufferLineSortByDirectory<CR>', { desc = "Sort Buffers by Directory" })
vim.keymap.set('n', '<leader><Tab>', ':tabnew<CR>', { desc = "Nouvel onglet" })

-- Lspsaga keymaps (global)
-- [removed: migrated to <leader>l* block below]

-- Lspsaga keymaps (global) - use <leader>l* to avoid conflicts with Snacks pickers
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder" })
vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })
vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>lj", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek Type Def" })
vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "Symbols Outline" })
vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Cursor Diagnostics" })
vim.keymap.set("n", "<leader>lD", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>lN", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })