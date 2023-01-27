local tree = require 'nvim-tree'
local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

tree.setup {
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	filters = {
		dotfiles = false,
		custom = { '.git', 'node_modules', '.cache' },
	},
	ignore_ft_on_setup = {
		'dashboard',
		'startify',
		'alpha',
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = '',
			info = '',
			warning = '',
			error = '',
		},
	},

	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		update_root = true,
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		side = 'right',
		width = 30,
	},
}

g.nvim_tree_icons = {
	default = '',
	symlink = '',
	git = {
		deleted = '',
		ignored = '◌',
		renamed = '➜',
		staged = '✓',
		unmerged = '',
		unstaged = '✗',
		untracked = '★',
	},
	folder = {
		default = '',
		empty = '',
		empty_open = '',
		open = '',
		symlink = '',
		symlink_open = '',
	},
}
g.nvim_tree_indent_markers = 1

-- keymaps
map('n', '<leader>o', '<cmd>NvimTreeFindFile<CR>', opts)
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
