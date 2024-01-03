return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    setup = {
      show_help = true,
      key_labels = { spelling = true },
      triggers = 'auto',
      window = {
        border = 'single', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'left', -- align columns left, center or right
      },
      hidden = {
        '<silent>',
        '<cmd>',
        '<Cmd>',
        '<CR>',
        'call',
        'lua',
        '^:',
        '^ ',
        '<Plug>',
        '<plug>',
      },
      operators = {
        operators = {
          gc = 'comment-line',
          gb = 'comment-block',
          s = 'substitute',
        },
      },
      plugins = {
        spelling = { enabled = true },
      },
    },
    defaults = {
      mode = { 'n', 'v' },
      ['<leader>f'] = { name = '+File' },
      ['<leader>q'] = { name = '+Session' },
      ['<leader>g'] = { name = '+Git' },
      ['<leader>w'] = { cmd = '<cmd>update!<cr>', desc = 'Save' },
    },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts.setupp)
    wk.register(opts.defaults)
  end,
}
