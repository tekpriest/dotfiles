local ts = require("nvim-treesitter.configs")

ts.setup({
	ensure_installed = { "dart", "typescript", "javascript", "svelte", "markdown", "lua", "yaml", "ocaml", "elixir" },
	highlight = {
		enable = true,
		use_languagetree = true,
		disable = { "haskell" },
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	context_commentstring = { enable = true },
	raibow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	autotag = {
		enable = true,
		filetypes = { "html", "javascript", "typescript", "markdown" },
	},

	ignore_installed = { "haskell" },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<TAB>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>pf"] = "@function.outer",
				["<leader>pc"] = "@class.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	-- indent = {
	--     enable = false
	-- },
	-- query_linter = {
	--     enable = true,
	--     use_virtual_text = true,
	--     lint_events = {"BufWrite", "CursorHold"}
	-- }
})
