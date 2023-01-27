local fn = vim.fn
-- bootstrap packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify 'downloading packer.nvim...'
	fn.system {
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	}
end
vim.cmd 'packadd! packer.nvim'

require('packer').startup {
	function(use)
		-- plugin manager
		use { 'wbthomason/packer.nvim', opt = true }

		use 'folke/tokyonight.nvim'
		use { 'catppuccin/nvim', as = 'catppuccin' }
		use { 'rebelot/kanagawa.nvim' }
		-- Optimiser
		use {
			'lewis6991/impatient.nvim',
		}
		-- Lua functions
		use {
			'nvim-lua/plenary.nvim',
		}
		-- Popup API
		use {
			'nvim-lua/popup.nvim',
		}
		-- icons
		use { 'kyazdani42/nvim-web-devicons' }
		-- file explorer
		-- use { 'kyazdani42/nvim-tree.lua' }
		-- auto session
		use {
			'rmagatti/auto-session',
			config = function()
				require('auto-session').setup {}
			end,
		}

		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			event = 'BufWinEnter',
			config = function()
				require 'config.plugins.treesitter'
			end,
		}
		use {
			-- Parenthesis highlighting
			'p00f/nvim-ts-rainbow',
			after = 'nvim-treesitter',
		}
		use {
			-- Autoclose tags
			'windwp/nvim-ts-autotag',
			after = 'nvim-treesitter',
		}
		use {
			-- Context based commenting
			'JoosepAlviste/nvim-ts-context-commentstring',
			after = 'nvim-treesitter',
		}
		use {
			after = 'nvim-treesitter',
			'nvim-treesitter/playground',
		}

		use {
			'windwp/nvim-autopairs',
		}
		use { 'stevearc/dressing.nvim' }
		-- snippet engine
		use {
			'L3MON4D3/LuaSnip',
			config = function()
				require('luasnip/loaders/from_vscode').lazy_load()
			end,
			requires = {
				-- Snippet collections
				'rafamadriz/friendly-snippets',
			},
		}
		-- completion engine
		use {
			'hrsh7th/nvim-cmp',
			event = 'BufRead',
		}
		use { after = 'nvim-cmp', 'hrsh7th/cmp-nvim-lsp-signature-help' }
		-- snippet completion source
		use {
			after = 'nvim-cmp',
			'saadparwaiz1/cmp_luasnip',
		}
		-- buffer completion source
		use {
			after = 'nvim-cmp',
			'hrsh7th/cmp-buffer',
		}
		-- path completion source
		use {
			after = 'nvim-cmp',
			'hrsh7th/cmp-path',
		}
		-- LSP completion source
		use {
			after = 'nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
		}
		use {
			after = 'nvim-cmp',
			'hrsh7th/cmp-nvim-lsp-document-symbol',
		}
		use { after = 'nvim-cmp', 'hrsh7th/cmp-nvim-lua' }
		use { 'onsails/lspkind-nvim' }
		-- Cursorhold fix
		use {
			'antoinemadec/FixCursorHold.nvim',
			event = 'BufRead',
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		}
		-- fuzzy finder
		use {
			'nvim-telescope/telescope.nvim',
		}
		use {
			after = 'telescope.nvim',
			'kdheepak/lazygit.nvim',
		}
		-- fuzzy finder sytax support
		use {
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
			after = 'telescope.nvim',
		}
		use { 'lewis6991/gitsigns.nvim' }
		use {
			'lukas-reineke/indent-blankline.nvim',
		}
		-- Built-in LSP
		use {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		}

		-- formatting and linting
		use { 'jose-elias-alvarez/null-ls.nvim' }
		use { 'glepnir/galaxyline.nvim' }
		use { 'numToStr/Comment.nvim' }
		use { 'editorconfig/editorconfig-vim' }
		use { 'wakatime/vim-wakatime' } -- code time tracker
		use { 'akinsho/toggleterm.nvim' }
		use { 'mfussenegger/nvim-dap' }
		use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
		use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
		use { 'ray-x/go.nvim', requires = { 'ray-x/guihua.lua' } }
		use { 'ellisonleao/glow.nvim' }
		use 'lunarvim/synthwave84.nvim'
		-- install without yarn or npm
		use {
			'iamcco/markdown-preview.nvim',
			run = function()
				vim.fn['mkdp#util#install']()
			end,
		}
		--git diff
		use { 'p00f/clangd_extensions.nvim' }
		use { 'Civitasv/cmake-tools.nvim' }
		-- godot
		use { 'habamax/vim-godot' }
		use { 'nvim-neo-tree/neo-tree.nvim', requires = 'MunifTanjim/nui.nvim' }
		use { 'simrat39/rust-tools.nvim' }
		use { 'rebelot/heirline.nvim' }
	end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		},
		profile = {
			enable = true,
			threshold = 0.0001,
		},
		git = {
			clone_timeout = 300,
		},
		compile_on_sync = true,
	},
}
