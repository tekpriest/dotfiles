local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

local plugs = {
	-- dependencies
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	'kyazdani42/nvim-web-devicons',
  {'kyazdani42/nvim-tree.lua',config=true},
	'folke/neoconf.nvim',
	'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd [[colorscheme tokyonight]]
		end,
	},
	{ 'rmagatti/auto-session', config = true },
}

require('lazy').setup(plugs)

