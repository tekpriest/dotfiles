-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true, nowait = true }

map('i', 'jk', '<esc>', opts)
map('i', 'jj', '<esc>', opts)
map('i', 'kj', '<esc>', opts)