local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(vim.fn.glob(install_path)) > 0 then
	_G.packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end
vim.api.nvim_command("packadd packer.nvim")

return require("packer").startup({
	function(use)
		-- Packer can manage itself as an optional plugin
		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })
		use({ "wbthomason/packer.nvim" })
		use({
			"terrortylor/nvim-comment",
			config = function()
				require("nvim_comment").setup({
					hook = function()
						require("ts_context_commentstring.internal").update_commentstring()
					end,
				})
			end,
		})
		use({ "JoosepAlviste/nvim-ts-context-commentstring" })

		use({ "ojroques/nvim-bufdel" })
		use({ "kyazdani42/nvim-tree.lua" })
		use({
			"hoob3rt/lualine.nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
				opt = true,
			},
		})
		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("bufferline").setup({
					options = {
						numbrs = "none",
						tab_size = 10,
						diagnostics = "nvim_lsp",
					},
				})
			end,
		})

		-- Themes
		use({ "morhetz/gruvbox" })
		use({ "rebelot/kanagawa.nvim" })
		use({ "mhartington/oceanic-next" })

		-- Editor Config
		use({ "editorconfig/editorconfig-vim" })

		-- Git
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup({
					numhl = true,
					signcolumn = false,
				})
			end,
		})

		-- -- Markdown
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && yarn install",
		})
		use({ "HerringtonDarkholme/yats.vim" })
		use({ "mhartington/formatter.nvim" })

		-- Go
		use({ "fatih/vim-go" })
		-- Prisma
		use({ "pantharshit00/vim-prisma" })

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use({ "nvim-treesitter/nvim-treesitter-textobjects" })
		use({ "nvim-treesitter/playground" })
		use({ "p00f/nvim-ts-rainbow" })
		use({
			"romgrk/nvim-treesitter-context",
			config = function()
				require("treesitter-context.config").setup({ enable = true })
			end,
		})
		use({ "glepnir/lspsaga.nvim" })
		use({ "neovim/nvim-lspconfig" })
		use({ "jose-elias-alvarez/null-ls.nvim" })
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

		-- autocomplete
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
			},
		})
		use({ "saadparwaiz1/cmp_luasnip" })
  --   use{'tzachar/cmp-tabnine',
  --   run ="./install.sh",
  --   config = function ()
  --     local tabnine='cmp_tabnine.config'
  --     tabnine:setup{
  --       max_lines = 1000,
  --       max_num_results = 20,
  --       sort = true
  --     }
  --   end
  -- }
		use({ "L3MON4D3/LuaSnip" })
    use{'tomlion/vim-solidity'}
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{
					"nvim-telescope/telescope-fzy-native.nvim",
					run = "make",
				},
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
			},
		})
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({ "nvim-telescope/telescope-ui-select.nvim" })
		use({
			"onsails/lspkind-nvim",
			requires = { { "famiu/bufdelete.nvim" } },
		})

		use({ "kyazdani42/nvim-web-devicons" })
		use({ "mjlbach/neovim-ui" })
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})
		use({ "goolord/alpha-nvim" })
		use({ "glepnir/dashboard-nvim" })
		use({ "wakatime/vim-wakatime" })
		use({ "folke/which-key.nvim" })
		use({
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup({ enable = true })
			end,
		})
		use({
			"simrat39/symbols-outline.nvim",
			cmd = { "SymbolsOutline" },
		})
		use({ "nvim-lua/lsp-status.nvim" })

		-- use({ "michaelb/sniprun", run = "bash ./install.sh" })

		use({
			"simrat39/rust-tools.nvim",
			config = function()
				require("rust-tools").setup({})
			end,
		})
		-- use({
		-- 	"akinsho/flutter-tools.nvim",
		-- 	requires = "nvim-lua/plenary.nvim",
		-- 	config = function ()
		-- 		require('flutter-tools').setup{}
		-- 	end
		-- })
    use{'j-hui/fidget.nvim',config = function ()
      require('fidget').setup{}
    end}

		if packer_bootstrap then
			require("packer").sync()
		end
	end,

	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		profile = {
			enable = true,
			threshold = 1,
		},
	},
})
