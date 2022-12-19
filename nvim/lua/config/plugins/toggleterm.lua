require('toggleterm').setup {}

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map('n', '<C-\\>', '<cmd>ToggleTerm<CR>', opts)
