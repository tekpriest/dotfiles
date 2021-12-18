local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require("packer").startup(function(use)
	-- Packer can manage itself as an optional plugin
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "wbthomason/packer.nvim" })
	--use {"Raimondi/delimitMate"}
	--use {"tpope/vim-repeat"}
	use({ "tpope/vim-unimpaired" })
	--use {"AndrewRadev/switch.vim"}
	use({ "christoomey/vim-tmux-navigator" })
	use({ "tpope/vim-surround" })
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

	use({ "junegunn/vim-easy-align" })
	--use {"junegunn/goyo.vim"}
	use({ "tmux-plugins/vim-tmux" })
	--use {"mhinz/vim-sayonara"}
	use({ "ojroques/nvim-bufdel" })
	--use {"mg979/vim-visual-multi"}
	use({ "vim-denops/denops.vim" })
	use({ "yukimemi/dps-asyngrep" })
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				auto_close = true,
				oen_on_tab = true,
				view = {
					side = "right",
					auto_resize = true,
				},
			})
		end,
	})
	use({ "Xuyuanp/yanil" })
	--[[
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			--vim.g.indent_blankline_char = "¦"
			--vim.g.indent_blankline_use_treesitter = false
			--vim.g.indent_blankline_show_current_context = false
			--vim.g.indent_blankline_show_trailing_blankline_indent = false,
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
				show_char_blankline = " ",
				char = "| ",
				filetype_exclude = { "help", "startify", "dashboard", "packer", "Yanil", "git", "text", "lspinfo" },
				buftype_exclude = { "terminal", "nofile" },
			})
		end,
	})
]]
	use({ "hoob3rt/lualine.nvim" })
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

	-- Colors
	use({ "morhetz/gruvbox" })
	--use {"patstockwell/vim-monokai-tasty"}
	--use {"arzg/vim-colors-xcode"}
	--use {"chuling/vim-equinusocio-material"}
	--use {"romgrk/github-light.vim"}
	--use {"Khaledgarbaya/night-owl-vim-theme"}
	--use {"kenwheeler/glow-in-the-dark-gucci-shark-bites-vim"}
	--use {"TroyFletcher/vim-colors-synthwave"}
	--use {"bluz71/vim-nightfly-guicolors"}

	-- Editor Config
	use({ "editorconfig/editorconfig-vim" })

	-- Git
	use({ "tpope/vim-fugitive" })
	--use {"tpope/vim-rhubarb"}
	--use {"sgeb/vim-diff-fold"}
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				debug_mode = false,
				signs = {
					add = { hl = "GitGutterAdd", text = "│" },
					change = { hl = "GitGutterChange", text = "│" },
					delete = { hl = "GitGutterDelete", text = "_" },
					topdelete = { hl = "GitGutterDelete", text = "‾" },
					changedelete = { hl = "GitGutterChangeDelete", text = "~" },
				},
			})
		end,
	})
	use({ "pwntester/octo.nvim" })
	-- use {"TimUntersberger/neogit"}
	use({ "sheerun/vim-polyglot" })

	-- -- Markdown
	use({ "tpope/vim-markdown", ft = "markdown" })
	--use {"rhysd/vim-grammarous"}
	--use {"nelstrom/vim-markdown-folding", ft = "markdown"}
	use({ "dhruvasagar/vim-table-mode" })
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
	})
	-- Rust
	--use {"rust-lang/rust.vim"}
	--use {"racer-rust/vim-racer"}
	-- Python
	--	use({ "tmhedberg/SimpylFold", ft = "python" })
	-- JS/TS
	--use {"othree/yajs.vim"}
	--use {"MaxMEllon/vim-jsx-pretty"}
	use({ "heavenshell/vim-jsdoc" })
	--use {"elzr/vim-json"}
	--use {"neoclide/jsonc.vim"}
	use({ "HerringtonDarkholme/yats.vim" })
	--use {"Quramy/vison"}
	--use {"jxnblk/vim-mdx-js"}
	-- HTML
	-- use {"othree/html5.vim"}
	--use {"mattn/emmet-vim"}
	--    use {"posva/vim-vue"}
	-- use {"leafOfTree/vim-svelte-plugin"}
	--    use {"skwp/vim-html-escape"}
	--    use {"kana/vim-textobj-user"}
	--    use {"whatyouhide/vim-textobj-xmlattr"}
	--    use {"pedrohdz/vim-yaml-folds"}
	-- CSS
	--  use {"hail2u/vim-css3-syntax"}
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				css = { rrggbbaa = true },
			})
		end,
	})
	-- Swift
	--use {"keith/swift.vim"}
	--    use {"gfontenot/vim-xcode"}
	-- Reason
	-- use{ "reasonml-editor/vim-reason-plus" }
	-- Go
	-- use{ "fatih/vim-go" }
	-- Lua
	use({ "tbastos/vim-lua" })

	use({ "mhartington/formatter.nvim" })
	--	use({ "mhartington/vim-folds" })
	use({ "mhartington/oceanic-next" })

	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter-angular" })
	use({ "nvim-treesitter/playground" })

	--use({ "hrsh7th/nvim-compe" })
	use({ "neovim/nvim-lspconfig" })
	use({ "glepnir/lspsaga.nvim" })
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	})
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- autocomplete
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	--snip
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	--
	--
	--
	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-github.nvim" })
	use({ "nvim-telescope/telescope-packer.nvim" })
	use({ "nvim-telescope/telescope-node-modules.nvim" })
	use({ "nvim-telescope/telescope-fzy-native.nvim" })

	use({ "kyazdani42/nvim-web-devicons" })
	-- use {"yamatsum/nvim-nonicons"}
	use({ "mjlbach/neovim-ui" })

	use({ "dstein64/vim-startuptime" })

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				--		check_ts = true,
				--enable_check_bracket_line = false,
				--				ts_config = {
				--					--lua = { "string" }, -- it will not add a pair on that treesitter node
				--					javascript = { "template_string" },
				--					typescript = { "template_string" },
				--				},
			})
		end,
	})

	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").opts)
		end,
	})

	use({ "glepnir/dashboard-nvim" })

	use({ "wakatime/vim-wakatime" })

	use({
		"Shatur/neovim-session-manager",
		config = function()
			require("session_manager").setup({})
		end,
	})
end)
