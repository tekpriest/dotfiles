return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    init = function()
      local rd = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rd.strategy['global'],
          vim = rd.strategy['local'],
          html = rd.strategy['local'],
        },
        query = {
          [''] = 'rinabow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  { 'b0o/SchemaStore.nvim', ft = { 'json', 'yaml' } },
  {
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {
      user_default_options = {
        mode = 'virtualtext',
      },
    },
  },
}
