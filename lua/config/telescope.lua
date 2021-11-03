local t = require('telescope')
local map = require('..keys')

require('telescope').setup {
  file_ignore_patterns = {"dist/*","node_modules/*"},
  shorten_path = true,
  color_devicons = true,
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      }
    },
    generic_sorter = require('telescope.sorters').get_fzy_sorter,
    file_sorer = require('telescope.sorters').get_fzy_sorter,
  }
}

map('n', '<leader>f', "<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n','<leader>b', "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', '<leader>s', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
