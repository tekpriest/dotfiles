-- orgmode
-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_configs.org = {
--   install_info = {
--     url = "https://github.com/milisims/tree-sitter-org",
--     revision = "f110024d539e676f25b72b7c80b0fd43c34264ef",
--     files = { "src/parser.c", "src/scanner.cc" },
--   },
--   filetype = "org",
-- }

require("orgmode").setup_ts_grammar()

require("nvim-treesitter.configs").setup({
	-- ensure_installed = "maintained",
	ignore_install = { "haskell", "norg" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	context_commentstring = { enable = true, enable_autocmd = false },
	indent = {
		enable = true,
	},
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
		lookahead = true,
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
	move = {
		enable = true,
		set_jumps = true, -- set jumps in the jumplist
		goto_next_start = {
			["]m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
	},
	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = false,
		max_file_lines = nil,
	},
	autopairs = { enable = true },
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	autotag = {
		enable = true,
	},
})
