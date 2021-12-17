local ts = require("nvim-treesitter.configs")

ts.setup({
	context_commentstring = { enable = true },
	ensure_installed = "maintained",
	ignore_installed = { "haskell" },
	highlight = {
		enable = true,
		use_languagetree = true,
		disable = { "haskell" },
	},
	indent = { enable = false },
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
})
