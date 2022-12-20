vim.api.nvim_create_autocmd({
	'BufWritePost',
}, {
	pattern = { '*.lua' },
	callback = function()
		vim.cmd [[ source <afile> ]]
	end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'qf', 'help', 'man', 'lspinfo', 'spectre_panel', 'spectre', 'lir' },
	callback = function()
		vim.cmd [[
    nnoremap <silent> <buffer> q :close<CR>
    ]]
	end,
})
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
	callback = function()
		vim.highlight.on_yank { higroup = 'Visual', timeout = 100 }
	end,
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'gitcommit', 'markdown' },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
vim.cmd [[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
vim.api.nvim_create_autocmd({ 'VimResized' }, {
	callback = function()
		vim.cmd 'tabdo wincmd ='
	end,
})
vim.api.nvim_create_autocmd({ 'BufEnter,BufRead' }, {
	pattern = { '*.conf*' },
	callback = function()
		vim.cmd [[setf dosini]]
	end,
})


