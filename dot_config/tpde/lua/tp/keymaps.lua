vim.keymap.set('n', '<leader><space>', ':Pick files<cr>')
vim.keymap.set('n', '<leader>cf', function()
	vim.lsp.buf.format()
end)

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true, nowait = true }

local keys = {
	n = {
		-- Better viewing
		['q'] = '<nop>',
		['Q'] = 'q',
		['<Up>'] = '<cmd>resize -2<cr>',
		['<Down>'] = '<cmd>resize +2<cr>',
		['<Left>'] = '<cmd>vertical resize -2<cr>',
		['<Right>'] = '<cmd>vertical resize +2<cr>',
		['<TAB>'] = [[<cmd>tabnext<cr>]],
		['<S-TAB>'] = [[<cmd>tabprevious<cr>]],
		['<leader>tn'] = [[<cmd>tabnew<cr>]],
		['<leader>tc'] = [[<cmd>tabclose<cr>]],
		['<leader>w='] = [[<C-w>=]],
		['<leader>wj'] = [[<C-w>j]],
		['<leader>wk'] = [[<C-w>k]],
		['<leader>wh'] = [[<C-w>h]],
		['<leader>wl'] = [[<C-w>l]],
		['<leader>qq'] = [[:qa!<cr>]],
		['<C-j>'] = [[<C-w>j]],
		['<C-k>'] = [[<C-w>k]],
		['<C-h>'] = [[<C-w>h]],
		['<C-l>'] = [[<C-w>l]],
		['<leader>wv'] = [[<C-w>v]],
		['<leader>ws'] = [[<C-w>s]],
		['<leader>wq'] = [[<C-w>q]]
	},
	v = {
		-- Better indent
		['>'] = '>gv',
		['<'] = '<gv',
		['q'] = '<nop>',
		['Q'] = 'q',
	},
	t = {
		['jk'] = '<C-\\><C-n>',
	},
	i = {
		['jk'] = '<ESC>',
		['jj'] = '<ESC>',
		-- Add undo breakpoints
		[','] = ',<c-g>u',
		['.'] = '.<c-g>u',
		[';'] = ';<c-g>u',
	},
	x = {
		['p'] = '"_dP',
	},
}

for mode, mode_tbl in pairs(keys) do
	for lhs, rhs in pairs(mode_tbl) do
		map(mode, lhs, rhs, opts)
	end
end

-- Auto indent
vim.keymap.set('n', 'i', function()
	if #vim.fn.getline '.' == 0 then
		return [["_cc]]
	else
		return 'i'
	end
end, { expr = true })
