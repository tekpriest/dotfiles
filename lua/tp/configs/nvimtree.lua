local tree = require("nvim-tree")
local g = vim.g

g.nvim_tree_group = 1

tree.setup({
	filters = {
		dotfiles = false,
		custom = {
			".git",
			"node_modules",
			"dist",
			".cache",
		},
	},
	ignore_ft_on_setup = {
		"dashboard",
		"startify",
		"alpha",
	},
	-- auto_close = true,
	open_on_tab = false,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	disable_netrw = true,
	hijack_netrw = true,
	quit_on_open = true,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 1,
		tree_width = 30,
	},
	view = {
		side = "right",
		auto_resize = true,
		width = 30,
	},
})
