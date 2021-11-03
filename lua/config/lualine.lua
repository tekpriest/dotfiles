local status, lualine = pcall(require, 'lualine')
if (not status) then return end

-- local gps = require('nvim-gps')

lualine.setup({
  options = {
    theme = 'onedark',
    icons_enabled = true,
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {'NvimTree'}
  },
  sections = {
    lualine_a = {},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      {'diagnostics', sources = {'nvim_lsp'}, symbols = {error =' ',warn =' ', info = ' ', hint = ' '}},
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
})
