local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
	return vim.api.nvim_create_augroup('tpde_' .. name, { clear = true })
end

autocmd('FileType', {
	group = augroup 'close_with_q',
	pattern = {
		'OverseerForm',
		'OverseerList',
		'checkhealth',
		'floggraph',
		'fugitive',
		'git',
		'help',
		'lspinfo',
		'man',
		'neotest-output',
		'neotest-summary',
		'qf',
		'query',
		'spectre_panel',
		'startuptime',
		'toggleterm',
		'tsplayground',
		'vim',
		'neoai-input',
		'neoai-output',
		'netrw',
		'notify',
		'Codi!!',
		'rest_nvim_results',
		'DressingInput',
		'dap-float',
		'TelescopePrompt',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set('n', 'q', '<cmd>close!<cr>', { buffer = event.buf, silent = true })
	end,
})

autocmd({ 'BufWinEnter' }, {
	group = augroup 'auto_format_options',
	callback = function()
		vim.cmd 'set formatoptions-=cro'
	end,
})

-- set .mdx and .md files to markdown
autocmd('FileType', {
	pattern = { 'gitcommit', 'markdown' },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd({ 'BufWritePre' }, {
	group = augroup 'auto_create_dir',
	callback = function(event)
		if event.match:match '^%w%w+://' then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

autocmd({ 'CursorHold' }, {
	group = augroup 'show_diagnostics',
	callback = function(_, bufnr)
		for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winid).zindex then
				return
			end
		end
		vim.diagnostic.open_float(bufnr, {
			scope = 'cursor',
			focusable = false,
			close_events = {
				'CursorMoved',
				'CursorMovedI',
				'BufHidden',
				'InsertCharPre',
				'WinLeave',
			},
		})
	end,
})

autocmd('FileType', {
	group = augroup 'buf_check',
	pattern = { 'NeogitCommitMessage' },
	command = 'startinsert | 1',
})

vim.api.nvim_create_user_command('ElixirToJson', function()
	vim.cmd [[%s/ =>/: /g]]
	vim.cmd [[%s/\<nil\>/null/g]]
end, {})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
