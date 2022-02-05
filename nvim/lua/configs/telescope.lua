local telescope = TP.require("telescope")
local actions = TP.require("telescope.actions")

telescope.setup({
  defaults = {
    windblend = 10,
    file_sorter = TP.require("telescope.sorters").get_fzy_sorter,
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
      theme = "ivy",
    },
  },
})
