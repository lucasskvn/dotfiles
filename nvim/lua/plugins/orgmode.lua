return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    vim.fn.mkdir(vim.fn.expand("~/orgfiles"), "p")
    local refile = vim.fn.expand("~/orgfiles/refile.org")
    local f = io.open(refile, "r")
    if not f then
      io.open(refile, "w"):close()
    else
      f:close()
    end
    require('orgmode').setup({
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    })

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
