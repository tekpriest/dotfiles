local vim = vim
local api = vim.api
local M = {}
function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
function M.mapBuf(buf, mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end

M.map("n", "Q", "<nop>")
M.map("n", "q", "<nop>")

M.map("n", "<Leader>H", "<cmd>TSHighlightCapturesUnderCursor<cr>")
M.map("n", "<leader>ff", "<cmd>lua require('kr.telescope').find_files()<cr>")
--M.map("n", "<Leader>h", "<cmd>lua require('kr.telescope').help_tags()<cr>")
--M.map("n", "<Leader>c", "<cmd>lua require('kr.telescope').colors()<cr>")
M.map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>")
M.map("n", "<leader>fc", "<cmd>Telescope git_status<CR>")
M.map("n", "<leader>fs", "<cmd>Telescope file_browser<CR>")
M.map("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
M.map("n", "<Leader>sf", "<cmd>Format<cr>", { nowait = true })
M.map("n", "H", "^")
M.map("n", "L", "g_")
M.map("v", "H", "^")
M.map("v", "L", "g_")
M.map("n", "J", "5j")
--M.map("n", "K", "5k")
M.map("v", "J", "5j")
M.map("v", "K", "5k")
M.map("v", "gJ", ":join<cr>")
M.map("n", ";", ":", { nowait = true, silent = false })
M.map("n", "<Space>", "za")
M.map("n", "<Space>", "za")
M.map("n", "<Leader>,", "<cmd>bnext<cr>")
M.map("n", "<Leader>.", "<cmd>bprevious<cr>")
M.map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
M.map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
M.map("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
M.map("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
M.map("v", "<", "<gv")
M.map("v", ">", ">gv")
M.map("n", "<Leader>d", '"_d')
M.map("v", "<Leader>d", '"_d')
M.map("n", "<Esc>", "<cmd>noh<cr>")
-- terminal M.mappings
M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")
M.map("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
M.map("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>")

M.map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("i", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("t", "<C-j>", "<c-\\><c-n>:TmuxNavigateDown<cr>")
M.map("t", "<C-k>", "<c-\\><c-n>:TmuxNavigateUp<cr>")
M.map("t", "<C-l>", "<c-\\><c-n>:TmuxNavigateRight<cr>")
M.map("t", "<C-h>", "<c-\\><c-n>:TmuxNavigateLeft<CR>")

M.map("n", "<Leader>tm", "<cmd>TableModeToggle<cr>")
M.map("n", "<Leader>u", "<cmd>PackerUpdate<cr>")

for i = 1, 9 do
	M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
	M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
end

vim.cmd("cnoreabbrev x Sayonara")

-- M.map("n", 'gc', "<cmd>lua require('ts_context_commentstring.internal').update_commentstring()<cr>")
-- vim.cmd("cnoreabbrev x BufDel")
-- vim.cmd("cnoreabbrev x! BufDel!")

-- tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
-- tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
-- tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
-- tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
-- tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

-- trouble
M.map("n", "<leader>xx", "<cmd>Trouble<cr>")
M.map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
M.map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
M.map("n", "<leader>xl", "<cmd>Touble loclist<cr>")
M.map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
M.map("n", "<leader>gR", "<cmd>Trouble lsp_references<cr>")

-- NVIM Tree
M.map("n", "<leader>f", "cmd>NvimTreeToggle<CR>")

-- JSDOC
--M.map("n", "<C-l>", "<cmd>JsDoc<CR>")

M.map("n", "<leader>c", "<cmd>CommentToggle<CR>", { nowait = true })

vim.cmd([[inoremap <silent><expr> <C-Space> compe#complete()]])

return M
