local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local map = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- remap space key as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down
map("n", "<A-j>", "<Esc><cmd>m .+1<CR>==", opts)
map("n", "<A-k>", "<Esc><cmd>m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>==gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>==gv=gv", opts)

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
map("n", "<leader>o", "<cmd>NvimTreeFindFileToggle<CR>", opts)

-- use jk/kj to escape
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- disable q/Q macro
map("n", "Q", "<nop>", opts)
map("n", "q", "<nop>", opts)

map("n", "Y", "y$", opts) -- copy till end of line
map("v", "p", '"_dP', opts)

-- Lazygit
map("n", "<leader>g", "<cmd>LazyGit<cr>", opts)

map("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", "fbg", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
map("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "tf", "<cmd>Telescope flutter commands<cr>")

-- Lspsaga
map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
map("n", "gla", "<cmd>Lspsaga code_action<CR>", opts)
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
map("n", "rn", "<cmd>Lspsaga rename<CR>", opts)
map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
