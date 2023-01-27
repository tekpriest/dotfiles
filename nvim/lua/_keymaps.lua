local M = {}

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

-- Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Move text up and down
map('n', '<A-j>', '<Esc><cmd>m .+1<CR>==', opts)
map('n', '<A-k>', '<Esc><cmd>m .-2<CR>==', opts)
map('v', '<A-j>', ":m '>+1<CR>==gv=gv", opts)
map('v', '<A-k>', ":m '<-2<CR>==gv=gv", opts)

-- use jk/kj to escape
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)

-- shift line
map('v', '<', '<gv', opts) -- backward
map('v', '<', '>gv', opts) -- forward

-- disable q/Q macro
map('n', 'Q', '<nop>', opts)
map('n', 'q', '<nop>', opts)

map('n', 'Y', 'y$', opts) -- copy till end of line
map('v', 'p', '"_dP', opts)

vim.keymap.set('n', '<leader>sc', function()
  require('_cheatsheet').cheatsheet()
end, { desc = 'Open CheatSheet' })
vim.keymap.set('n', '<leader>ss', function()
  require('_cheatsheet').stack_overflow()
end, { desc = 'Open CheatSheet' })
