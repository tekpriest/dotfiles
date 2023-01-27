local telescope = require 'telescope'
local actions = require 'telescope.actions'
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

telescope.load_extension 'lazygit'
telescope.load_extension 'fzf'
-- telescope.load_extension 'projects'

telescope.setup {
	defaults = {
		windblend = 10,
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		sorting_strategy = 'descending',
		layout_strategy = 'flex',
		layout_config = {
			flex = {
				flip_columns = 140,
			},
			vertical = {
				preview_cutoff = 40,
				prompt_position = 'bottom',
			},
			horizontal = {
				width = 0.9,
				height = 0.8,
			},
		},
		mappings = {
			i = {
				['<esc>'] = actions.close,
				['<CR>'] = actions.select_default,
				['<Tab>'] = actions.toggle_selection,
			},
		},
		prompt_prefix = ' ',
		selection_caret = '❯ ',
		path_display = { 'smart' },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
	pickers = {
		find_files = {
			theme = 'ivy',
		},
	},
}

-- telescope
map('n', 'ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map('n', 'fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map('n', 'fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map('n', 'gt', '<cmd>Telescope git_status<CR>', opts)
map('n', 'gc', '<cmd>Telescope git_commits<CR>', opts)
map('n', 'fh', '<cmd>Telescope help_tags<CR>', opts)
map('n', 'fo', '<cmd>Telescope oldfiles<CR>', opts)
map('n', 'fq', '<cmd>Telescope quickfix<CR>', opts)
map('n', '<leader>gg', '<cmd>Telescope lazygit<CR>', opts)
map('n', '<C-p>', '<cmd>Telescope projects<CR>', opts)
