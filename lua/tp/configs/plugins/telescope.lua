local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup{
  defaults = {
    windblend = 10,
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = " ",
		selection_caret = "❯ ",
    path_display = {'smart'},
    layout_strategy = 'flex',
    layout_config = {
      flex = {
        flip_columns = 140
      }
    },
    mappings = {
			i = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<Tab>"] = actions.toggle_selection,
			},
		}
  },
  extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
		},
	}
}

telescope.load_extension("lazygit")
telescope.load_extension("ui-select")
telescope.load_extension("fzf")
