local g = vim.g

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true, silent = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- Remap space as leader key
map('','<Space>', '<Nop>')
g.mapleader = ' '
g.maplocalleader = ' '

map('n','k',"v:count == 0 ? 'gk' :'k'",{expr = true})
map('n','j',"v:count == 0 ? 'gj' : 'j'", {expr = true})

--- Add move line shortcuts
map('n', '∆', '<cmd>m .+1<cr>==') -- Linux or Windows user <A-j>
map('n', '˚', '<cmd>m .-2<cr>==') -- Linux or Windows user <A-k>
map('i', '∆', '<Esc><cmd>m .+1<cr>==gi')
map('i', '˚', '<Esc><cmd>m .-2<cr>==gi')
map('v', '∆', "<cmd>m '>+1<cr>gv=gv'")
map('v', '˚', "<cmd>m '<-2<cr>gv=gv'")

map('n', 'Y', 'y$', {silent = false}) -- Yank till eol
map('n', '<leader>h', '<cmd>nohl<cr>')

-- jk / kj works!
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')

-- Tab for completion menu
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>": "\\<Tab>"', {expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>": "\\<Tab>"', {expr = true})

-- LSP
map('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
map('n', '<Space>ca', '<CMD>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Space>cr', '<CMD>lua vim.lsp.buf.rename()<CR>')
map('n', '<Space>cf', '<CMD>lua vim.lsp.buf.formatting()<CR>')

-- Spellinng
map('n','<F8>','<CMD>setlocal spell!<CR>')
return map
