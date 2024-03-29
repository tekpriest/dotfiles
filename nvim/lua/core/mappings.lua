local opts = { noremap = true, silent = true }

TP.map = vim.api.nvim_set_keymap
local map = TP.map

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate buffers
map("n", "tt", "<cmd>bnext<CR>", opts)
map("n", "tr", "<cmd>bprevious<CR>", opts)
-- Move text up and down
map("n", "<A-j>", "<Esc><cmd>m .+1<CR>==", opts)
map("n", "<A-k>", "<Esc><cmd>m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>==gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>==gv=gv", opts)
-- NvimTree
map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)
-- use jk/kj to escape
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
-- telescope
map("n", "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", "fbg", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
map("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "gt", "<cmd>Telescope git_status<CR>", opts)
map("n", "gc", "<cmd>Telescope git_commits<CR>", opts)
map("n", "fh", "<cmd>Telescope help_tags<CR>", opts)
map("n", "fo", "<cmd>Telescope oldfiles<CR>", opts)
map("n", "fq", "<cmd>Telescope quickfix<CR>", opts)

-- Lspsaga
map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
map("n", "gla", "<cmd>Lspsaga code_action<CR>", opts)
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
map("n", "rn", "<cmd>Lspsaga rename<CR>", opts)
map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)

-- Comment
map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
map("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

map("v", "<", "<gv", opts) -- shift line backward
map("v", "<", ">gv", opts) -- shift line forward

-- disable q/Q macro
map("n", "Q", "<nop>", opts)
map("n", "q", "<nop>", opts)

map("n", "Y", "y$", opts) -- copy till end of line
map("v", "p", '"_dP', opts)

-- symbol outline
map("n", "<leader>s", "<cmd>SymbolsOutline<cr>", opts)

-- format
map("n", "<leader>f", "<cmd>autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()<cr>", opts)
-- treesitter playground
map("n", "<leader>t", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)

-- Yode
map("n", "<Leader>bd", "<cmd>YodeBufferDelete<cr>", opts)

-- Lazygit
map("n", "<leader>g", "<cmd>LazyGit<cr>", opts)
