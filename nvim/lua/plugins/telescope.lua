local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local actions = require 'telescope.actions'

require('telescope').setup {
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
        preview_width = 0.5,
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
    file_ignore_patterns = { 'node_modules', '.git' },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    project = {
      base_dirs = { '~/Code/furex', '~/Code/yebox' },
      sync_with_nvim_tree = true,
    },
  },
  pickers = {
    find_files = {
      theme = 'ivy',
    },
  },
}

map('n', 'ff', require('telescope.builtin').find_files, { desc = 'Telescope: Find files' })
map(
  'n',
  'fl',
  require('telescope.builtin').current_buffer_fuzzy_find,
  { desc = 'Telescope: Find current buffer' }
)
map('n', 'fg', require('telescope.builtin').live_grep, { desc = 'Telescope: Live grep' })
map('n', 'fb', require('telescope.builtin').buffers, {})
map('n', '<leader>gc', require('telescope.builtin').git_commits, {})
map('n', 'fq', '<cmd>Telescope quickfix<CR>', opts)
map('n', '<leader>gg', '<cmd>LazyGit<CR>', {})
-- map('n', '<C-p>', require('telescope.builtin').project, {})
