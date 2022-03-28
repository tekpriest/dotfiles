local telescope = require("telescope")
local actions = require("telescope.actions")

-- extensions
telescope.load_extension('lazygit')
telescope.load_extension('fzf')

telescope.setup{
  defaults = {
    winblend = 10,
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 140,
      },
    },
    mappings = {
      i = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<Tab>"] = actions.toggle_selection,
			},
    },
    prompt_prefix = " ",
		selection_caret = "❯ ",
		path_display = { "smart" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      theme = "ivy"
    }
  }
}
