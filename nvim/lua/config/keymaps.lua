-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true, nowait = true }

-- better escape
map('i', 'jk', '<esc>', opts)
map('i', 'jj', '<esc>', opts)

-- ignore q/Q
map('n', 'q', '<nop>', opts)
map('n', 'Q', '<nop>', opts)

-- resize panes
map('n', '<Up>', '<cmd>resize +2<cr>', opts)
map('n', '<Down>', '<cmd>resize -2<cr>', opts)
map('n', '<Left>', '<cmd>vertical resize +2<cr>', opts)
map('n', '<Right>', '<cmd>vertical resize -2<cr>', opts)

-- switch between tabs
map('n', '<TAB>', '<cmd>tabnext<cr>', opts)
map('n', '<S-TAB>', '<cmd>tabprevious<cr>', opts)
