local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		winblend = 10,
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		sorting_strategy = "descending",
		layout_strategy = "flex",
		layout_config = {
			flex = {
				flip_columns = 140,
			},
			vertical = {
				preview_cutoff = 40,
				prompt_position = "bottom",
			},
			horizontal = {
				width = 0.9,
				height = 0.8,
			},
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<Tab>"] = actions.toggle_selection,
			},
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		notify = {
			notify = {},
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
			prompt_prefix = "🔍",
		},
		live_grep = {
			theme = "ivy",
		},
	},
})

telescope.load_extension("ui-select")
-- telescope.load_extension("sessions")
telescope.load_extension("file_browser")
telescope.load_extension("fzy_native")
-- telescope.load_extension("flutter")
