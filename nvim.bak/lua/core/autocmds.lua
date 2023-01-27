vim.api.nvim_create_autocmd({
	'BufWritePost',
}, {
	pattern = { 'plugins.lua', '~/.config/nvim/lua/**/*.lua' },
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
vim.api.nvim_create_autocmd({ 'BufEnter,BufRead' }, {
	pattern = { 'project.godot' },
	callback = function()
		print 'true'
		vim.cmd [[setf toml]]
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
-- vim.cmd [[autocmd BufEnter * ]]
vim.api.nvim_create_autocmd({ 'VimResized' }, {
	callback = function()
		vim.cmd 'tabdo wincmd ='
	end,
})
vim.api.nvim_create_autocmd({ 'BufEnter,BufRead' }, {
	pattern = { '*.conf' },
	callback = function()
		vim.cmd [[setf dosini]]
	end,
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	pattern = { '*' },
	callback = function()
		require('lazygit.utils').project_root_dir()
	end,
})
--[[vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	pattern = { '*' },
	callback = function()
		vim.cmd [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]
	end,
})]]
