-- bootstrap plugins
TP.bootstrap_plugin()

local packer = TP.require("packer")

packer.startup({
	function(use)
		-- plugin manager
		use({ "wbthomason/packer.nvim", opt = true })
		-- colorscheme
		use({ "rebelot/kanagawa.nvim" })
		use({ "glepnir/zephyr-nvim" })
		-- Optimiser
		use({
			"lewis6991/impatient.nvim",
		})
		-- Lua functions
		use({
			"nvim-lua/plenary.nvim",
		})
		-- Popup API
		use({
			"nvim-lua/popup.nvim",
		})
		-- Boost startup time
		use({
			"nathom/filetype.nvim",
			config = function()
				vim.g.did_load_filetypes = 1
			end,
		})
		-- Cursorhold fix
		use({
			"antoinemadec/FixCursorHold.nvim",
			event = "BufRead",
			config = function()
				vim.g.cursorhold_updatetime = 100
			end,
		})
		-- icons
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				return require("configs.icons")
			end,
		})
		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				return require("configs.nvimtree")
			end,
		})
		-- buffer display
		use({
			"akinsho/bufferline.nvim",
			after = "nvim-web-devicons",
			config = function()
				return require("configs.buffer")
			end,
		})
		-- statusline
		use({
			"nvim-lualine/lualine.nvim",
			after = "bufferline.nvim",
			config = function()
				return require("configs.lualine")
			end,
		})
		-- lsp progress
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		})
		-- editor config
		use({ "editorconfig/editorconfig-vim" })
		-- wakatime
		use({ "wakatime/vim-wakatime" })
		-- snippet engine
		use({
			"L3MON4D3/LuaSnip",
			config = function()
				require("luasnip/loaders/from_vscode").lazy_load()
			end,
			requires = {
				-- Snippet collections
				"rafamadriz/friendly-snippets",
			},
		})
		-- completion engine
		use({
			"hrsh7th/nvim-cmp",
			event = "BufRead",
			config = function()
				return require("configs.cmp")
			end,
		})
		use({ after = "nvim-cmp", "hrsh7th/cmp-nvim-lsp-signature-help" })
		-- snippet completion source
		use({
			"saadparwaiz1/cmp_luasnip",
			after = "nvim-cmp",
		})
		-- buffer completion source
		use({
			"hrsh7th/cmp-buffer",
			after = "nvim-cmp",
		})
		-- path completion source
		use({
			"hrsh7th/cmp-path",
			after = "nvim-cmp",
		})
		-- LSP completion source
		use({
			"hrsh7th/cmp-nvim-lsp",
		})
		use({
			"hrsh7th/cmp-nvim-lsp-document-symbol",
		})
		use({
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				return require("configs.autopairs")
			end,
		})
		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
			config = function()
				return require("configs.comment")
			end,
		})
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			-- event = "BufRead",
			config = function()
				return require("configs.treesitter")
			end,
			requires = {
				{
					-- Parenthesis highlighting
					"p00f/nvim-ts-rainbow",
					-- after = "nvim-treesitter",
				},
				{
					-- Autoclose tags
					"windwp/nvim-ts-autotag",
					-- after = "nvim-treesitter",
				},
				{
					-- Context based commenting
					"JoosepAlviste/nvim-ts-context-commentstring",
					-- after = "nvim-treesitter",
				},
				{
					"nvim-treesitter/playground",
				},
			},
		})
		-- fuzzy finder
		use({
			"nvim-telescope/telescope.nvim",
			config = function()
				return require("configs.telescope")
			end,
		})
		-- fuzzy finder sytax support
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			after = "telescope.nvim",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		})
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			event = "BufRead",
			config = function()
				require("configs.gitsign")
			end,
		})
		-- Color highlighting
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				return require("colorizer").setup({})
			end,
		})
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				return require("configs.indent-line")
			end,
		})
		-- smooth, slick scroll
		use({
			"karb94/neoscroll.nvim",
			event = "BufRead",
			config = function()
				return require("configs.neoscroll")
			end,
		})
		-- Built-in LSP
		use({
			"neovim/nvim-lspconfig",
			config = function()
				require("configs.lsp")
			end,
		})
		use({ "onsails/lspkind-nvim" })
		use({
			"onsails/diaglist.nvim",
			config = function()
				TP.require("diaglist").init({})
			end,
		})
		-- lsp symbols
		use({
			"simrat39/symbols-outline.nvim",
			setup = function()
				vim.g.symbols_outline = {
					width = 20,
				}
			end,
		})
		-- lsp enhancer
		use({
			"tami5/lspsaga.nvim",
			event = "BufRead",
			config = function()
				require("configs.lspsaga")
			end,
		})
		-- formatting and linting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		-- auto session
		use({
			"rmagatti/auto-session",
			config = function()
				require("auto-session").setup({})
			end,
		})
		-- flutter
		use({
			"akinsho/flutter-tools.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("flutter-tools").setup({
					widget_guides = {
						enabled = true,
					},
				})
			end,
		})
		-- rust tool
		use({
			"simrat39/rust-tools.nvim",
			ft = { "rust" },
			config = function()
				require("rust-tools").setup({})
			end,
		})
		-- lsp status
		use({ "nvim-lua/lsp-status.nvim" })
		-- better buffer closing
		use({
			"moll/vim-bbye",
			after = "bufferline.nvim",
		})
		use({
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("configs.alpha")
			end,
		})
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && yarn install",
		})
		use({ "ojroques/nvim-bufdel" })
		use({
			"nvim-orgmode/orgmode",
			config = function()
				require("orgmode").setup({
					org_agenda_files = { "~/Code/orgs/*" },
				})
			end,
		})
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
		use({ "b0o/SchemaStore.nvim" })
		use({
			"hoschi/yode-nvim",
			config = function()
				require("yode-nvim").setup({})
			end,
		})
		-- Godot
		use({ "habamax/vim-godot" })
		-- use({ "williamboman/nvim-lsp-installer" })
		-- use gituhub copilot
		use({ "github/copilot.vim" })
		use({ "stevearc/dressing.nvim" })
		-- theme for men of culture
		use({ "gruvbox-community/gruvbox" })
		-- spacemacs-like statusline
		-- use({ "glepnir/spaceline.vim" })
		use({ "ziglang/zig.vim" })
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		profile = {
			enable = true,
			threshold = 0.0001,
		},
		git = {
			clone_timeout = 300,
		},
		auto_clean = true,
		compile_on_sync = true,
	},
})
