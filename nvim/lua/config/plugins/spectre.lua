require('spectre').setup {}

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map('n', '<leader>ss', "<cmd>lua require('spectre').open_visual()<CR>", opts)
