return {
  'folke/which-key.nvim',
  name = 'whichkey',
  lazy = false,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spelling = {
      enabled = true,
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
    -- plugins = {
    --   marks = false,
    --   registers = false,
    --   spelling = {
    --     enabled = false,
    --   },
    --   presets = {
    --     operators = false,
    --     motions = false,
    --     text_objects = false,
    --     windows = false,
    --     nav = false,
    --     z = false,
    --     g = false,
    --   },
    -- },
  },
}
