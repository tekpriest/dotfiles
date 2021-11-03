local fmt = string.format
local fn = vim.fn
local paq_dir = fmt("%s/site/pack/packer/start/packer.nvim", fn.stdpath("data"))

if fn.empty(fn.glob(paq_dir)) > 0 then
	fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim.git", paq_dir })
end

require("packer").startup(function(use)
	-- Package Manager
	use("wbthomason/packer.nvim")

	--- Colorschemes
	use("sainnhe/gruvbox-material")
	use("savq/melange")
	use("navarasu/onedark.nvim")
	use("olimorris/onedarkpro.nvim")

	-- Core
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"kyazdani42/nvim-web-devicons",
		opt = true,
	})

	--- Misc
	use("sheerun/vim-polyglot")
	-- auto close delimiters
	use("kana/vim-smartinput")

	use("airblade/vim-rooter")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		on = "NvimTreeToggle",
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		opt = true,
	})

	-- Git stuff
	use("airblade/vim-gitgutter")
	use("tpope/vim-fugitive")

	--- Statusline
	use("nvim-lualine/lualine.nvim")

	-- Treesitter
	use("sbdchd/neoformat")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"go",
					"gomod",
					"javascrip",
					"json",
					"lua",
					"svelte",
					"typescript",
					"yaml",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	})
	use("nvim-treesitter/playground")
	--
	-- LSP & Language Support
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})
	use("onsails/lspkind-nvim")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

	-- Snippets
	use("honza/vim-snippets")

	-- Editorconfig
	use("editorconfig/editorconfig-vim")

	-- Markup
	use({ "lervag/wiki.vim", opt = true })
	use({ "gabrielelana/vim-markdown", opt = true, ft = { "markdown" } })

	-- Tab
	use("romgrk/barbar.nvim")

	-- UI
	use({ "glepnir/dashboard-nvim" })

	-- Clap for Dashboard
	use({ "liuchengxu/vim-clap", run = ":Clap install-binary" })

	-- Prisma
	use("pantharshit00/vim-prisma")
end)

-- Set Theme automatically
require("onedarkpro").load()
vim.cmd([[let g:onedark_style = 'darker']])
