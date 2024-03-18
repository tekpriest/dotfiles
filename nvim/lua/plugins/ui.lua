return {
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    init = function()
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
    opts = {
      autowidth = {
        winwidth = 15,
      },
    },
    config = function(_, opts) require('windows').setup(opts) end,
    keys = {
      {
        '<c-w>z',
        '<cmd>WindowsMaximize<cr>',
        desc = 'Zoom window',
      },
      {
        '<c-w>=',
        '<cmd>WindowsEqualize<cr>',
        desc = 'Reset zoom',
      },
    },
  },
}

