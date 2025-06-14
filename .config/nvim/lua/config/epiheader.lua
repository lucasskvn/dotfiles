-- EPIHEADER VIMRC TRAD INTO LUA

-- Consider *.h files as *.c
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.h',
  command = 'set filetype=c',
})

-- Epitech Header
local comMapNoShebang = {
  c = { b = '/*', m = '**', e = '*/' },
  cpp = { b = '//', m = '//', e = '//' },
  make = { b = '##', m = '##', e = '##' },
  java = { b = '//', m = '//', e = '//' },
  latex = { b = '%%', m = '%%', e = '%%' },
  html = { b = '<!--', m = '  --', e = '-->' },
  lisp = { b = ';;', m = ';;', e = ';;' },
  css = { b = '/*', m = '**', e = '*/' },
  pov = { b = '//', m = '//', e = '//' },
  pascal = { b = '{ ', m = '   ', e = '}' },
  haskell = { b = '{-', m = '-- ', e = '-}' },
  vim = { b = '""', m = '"" ', e = '""' },
}

local comMapShebang = {
  sh = { s = '#!/usr/bin/env sh', b = '##', m = '##', e = '##' },
  bash = { s = '#!/usr/bin/env bash', b = '##', m = '##', e = '##' },
  zsh = { s = '#!/usr/bin/env zsh', b = '##', m = '##', e = '##' },
  php = { s = '#!/usr/bin/env php', b = '/*', m = '**', e = '*/' },
  perl = { s = '#!/usr/bin/env perl', b = '##', m = '##', e = '##' },
  python = { s = '#!/usr/bin/env python3', b = '##', m = '##', e = '##' },
  ruby = { s = '#!/usr/bin/env ruby', b = '##', m = '##', e = '##' },
  node = { s = '#!/usr/bin/env node', b = '/*', m = '**', e = '*/' },
}

local function Epiyear()
  return os.date '%Y'
end

local function InsertFirst()
  vim.fn.inputsave()
  local proj_name = vim.fn.input 'Enter project name: '
  local file_desc = vim.fn.input 'Enter file description: '
  vim.fn.inputrestore()
  vim.cmd('1,6s/µPROJECTNAMEµ/' .. proj_name .. '/ge')
  vim.cmd('1,6s/µYEARµ/' .. Epiyear() .. '/ge')
  vim.cmd('1,6s/µFILEDESCµ/' .. file_desc .. '/ge')
end

local function IsSupportedFt()
  return comMapNoShebang[vim.bo.filetype] ~= nil
end

local function IsSupportedFtShebang()
  return comMapShebang[vim.bo.filetype] ~= nil
end

local function Epi_header()
  local Has_Shebang
  if IsSupportedFt() then
    Has_Shebang = 0
  elseif IsSupportedFtShebang() then
    Has_Shebang = 1
  else
    vim.api.nvim_err_writeln(
      'Epitech header: Unsupported filetype: ' .. vim.bo.filetype .. ' If you think this an error or you want an additional filetype please contact me :)'
    )
    return
  end

  if Has_Shebang == 0 then
    local bcom = comMapNoShebang[vim.bo.filetype].b
    local mcom = comMapNoShebang[vim.bo.filetype].m
    local ecom = comMapNoShebang[vim.bo.filetype].e

    vim.fn.append(0, bcom)
    vim.fn.append(1, mcom .. ' EPITECH PROJECT, µYEARµ')
    vim.fn.append(2, mcom .. ' µPROJECTNAMEµ')
    vim.fn.append(3, mcom .. ' File description:')
    vim.fn.append(4, mcom .. ' µFILEDESCµ')
    vim.fn.append(5, ecom)
  else
    local scom = comMapShebang[vim.bo.filetype].s
    local bcom = comMapShebang[vim.bo.filetype].b
    local mcom = comMapShebang[vim.bo.filetype].m
    local ecom = comMapShebang[vim.bo.filetype].e

    vim.fn.append(0, scom)
    vim.fn.append(1, bcom)
    vim.fn.append(2, mcom .. ' EPITECH PROJECT, µYEARµ')
    vim.fn.append(3, mcom .. ' µPROJECTNAMEµ')
    vim.fn.append(4, mcom .. ' File description:')
    vim.fn.append(5, mcom .. ' µFILEDESCµ')
    vim.fn.append(6, ecom)
  end
  InsertFirst()
  vim.cmd '8'
end

vim.api.nvim_create_user_command('EpiHeader', Epi_header, {})

-- Compile command
local function Compile()
  local ccommand = 'make'
  vim.cmd 'echohl Question'
  ccommand = vim.fn.input('compile : ', ccommand)
  vim.cmd 'echohl None'

  vim.opt.makeprg = ccommand
  vim.cmd 'make'
end

vim.api.nvim_create_user_command('Compile', Compile, {})

-- Goto line command
local function GotoLine()
  local gotoline_n = ''
  vim.cmd 'echohl Question'
  gotoline_n = vim.fn.input('Goto Line : ', gotoline_n)
  vim.cmd 'echohl None'

  vim.cmd(gotoline_n)
end

vim.api.nvim_create_user_command('GotoLine', GotoLine, {})

-- END OF TRAD
