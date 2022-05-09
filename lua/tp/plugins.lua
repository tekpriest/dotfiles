local vim = vim
local bootstrap_plugin = function()
	local fn = vim.fn
	-- bootstrap packer
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
		use({ "windwp/nvim-autopairs" })
		-- colorscheme
		use({ "rebelot/kanagawa.nvim" })
		use({ "gruvbox-community/gruvbox" })
		-- optimizer
		use({ "lewis6991/impatient.nvim" })
		-- file explorer
		use({ "kyazdani42/nvim-tree.lua" })
		use({ "kyazdani42/nvim-web-devicons" })
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
			tag = "v2.*",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		})
		use({ "kdheepak/lazygit.nvim" })
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({ "lukas-reineke/indent-blankline.nvim" })
		use({ "karb94/neoscroll.nvim" })
		use({
			"neovim/nvim-lspconfig",
			wants = { "nvim-lsp-installer" },
		})
		use({ "williamboman/nvim-lsp-installer" })
		use({ "nvim-lua/lsp-status.nvim" })
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
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
				{
					"nvim-treesitter/nvim-treesitter-textobjects",
				},
			},
		})
		use({ "tami5/lspsaga.nvim" })
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
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
		use({ "nvim-lualine/lualine.nvim" })
		use({
			"numToStr/Comment.nvim",
			requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
		})
		use({
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		-- use { "github/copilot.vim" }
		use({ "ziglang/zig.vim" })
		use({
			"stevearc/dressing.nvim",
			config = function()
				return require("dressing")
			end,
		})
		use({
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			config = function()
				return require("nvim-gps").setup()
			end,
		})
		use({
			"ThePrimeagen/harpoon",
			config = function()
				require("harpoon").setup({})
			end,
		})
		use({
			"akinsho/git-conflict.nvim",
			config = function()
				require("git-conflict").setup()
			end,
		})
		use("antoinemadec/FixCursorHold.nvim")
		use({ "folke/which-key.nvim" })
		use({
			"folke/trouble.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("trouble")
			end,
		})
		use({
			"AckslD/nvim-neoclip.lua",
			requires = { "nvim-telescope/telescope.nvim" },
			config = function()
				require("neoclip").setup()
			end,
		})
		use({
			"danymat/neogen",
			requires = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("neogen").setup({
					snippet_engine = "luasnip",
				})
			end,
		})
		use({
			"mfussenegger/nvim-jdtls",
		})
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
				{
					"s1n7ax/nvim-window-picker",
					tag = "1.*",
				},
			},
		})
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
