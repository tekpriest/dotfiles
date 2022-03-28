local bootstrap_plugin = function()
	local fn = vim.fn
	-- bootstrap packer
	local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		vim.notify("downloading packer.nvim...")
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
	end
	vim.cmd("packadd! packer.nvim")
	--require('packer').sync()
end

bootstrap_plugin()

require("packer").startup({
	function(use)
		-- plugin manager
		use({ "wbthomason/packer.nvim" })
		-- lua functions
		use({ "nvim-lua/plenary.nvim" })
		use({
			"windwp/nvim-autopairs",
			config = function()
				return require("tp.configs.autopairs")
			end,
		})
		-- colorscheme
		use({ "rebelot/kanagawa.nvim" })
		use({ "glepnir/zephyr-nvim" })
		use({ "romgrk/doom-one.vim" })
		use({ "gruvbox-community/gruvbox" })
		-- optimizer
		use({ "lewis6991/impatient.nvim" })
		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				return require("tp.configs.nvimtree")
			end,
		})
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				return require("tp.configs.icons")
			end,
		})
		-- code time tracker
		use({ "wakatime/vim-wakatime" })
		-- snippet engine
		use({
			"L3MON4D3/LuaSnip",
			config = function()
				return require("luasnip/loaders/from_vscode").lazy_load()
			end,
			requires = {
				-- snippet collections
				"rafamadriz/friendly-snippets",
			},
		})
		-- auto session
		use({
			"rmagatti/auto-session",
			config = function()
				require("auto-session").setup({})
			end,
		})
		-- add vscode-like pictograms to neovim
		use({ "onsails/lspkind-nvim" })
		-- completion engine
		use({
			"hrsh7th/nvim-cmp",
			config = function()
				return require("tp.configs.cmp")
			end,
			requires = {
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			},
		})
		-- buffer tabs with super power
		use({
			"akinsho/bufferline.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				return require("tp.configs.bufferline")
			end,
		})
		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				return require("tp.configs.telescope")
			end,
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		})
		use({ "kdheepak/lazygit.nvim" })
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				return require("tp.configs.gitsigns")
			end,
		})
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				return require("tp.configs.indentblankline")
			end,
		})
		use({
			"karb94/neoscroll.nvim",
			config = function()
				return require("tp.configs.neoscroll")
			end,
		})
		use({
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-lsp-installer" },
			config = function()
				return require("tp.configs.lsp")
			end,
		})
		use({ "williamboman/nvim-lsp-installer" })
		use({ "nvim-lua/lsp-status.nvim" })
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				return require("tp.configs.treesitter")
			end,
			requires = {
				{
					-- Parenthesis highlighting
					"p00f/nvim-ts-rainbow",
				},
				{
					-- Autoclose tags
					"windwp/nvim-ts-autotag",
				},
				{
					-- Context based commenting
					"JoosepAlviste/nvim-ts-context-commentstring",
				},
				{
					"nvim-treesitter/playground",
				},
			},
		})
		use({
			"tami5/lspsaga.nvim",
			config = function()
				return require("tp.configs.lspsaga")
			end,
		})
		use({ "editorconfig/editorconfig-vim" })
		-- lsp progress
		use({
			"j-hui/fidget.nvim",
			config = function()
				return require("fidget").setup({})
			end,
		})
		-- formatting and linting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
    use{
      'nvim-lualine/lualine.nvim',
      config = function()
        return require("tp.configs.lualine")
      end
    }
    use{
      'numToStr/Comment.nvim',
      requires = {'JoosepAlviste/nvim-ts-context-commentstring'},
      config = function()
        return require('tp.configs.comment')
      end
    }
     use{
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("tp.configs.alpha")
			end,
		}
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		profile = {
			enable = true,
			threshold = 0.001,
		},
		git = {
			clone_timeout = 300,
		},
		auto_clean = true,
		compile_on_sync = true,
	},
})
