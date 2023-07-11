return {
  'Vigemus/iron.nvim',
  cmd = { 'IronRepl', 'IronFocus' },
  dependencies = { 'whichkey' },
  init = function()
    local wk = require 'which-key'

    wk.register({
      r = {
        o = { '<cmd>IronRepl<cr>', 'open repl' },
        r = { '<cmd>IronRestart<cr>', 'restart repl' },
        f = { '<cmd>IronFocus<cr>', 'focus repl' },
        h = { '<cmd>IronHide<cr>', 'hide repl' },
      },
    }, {
      prefix = '<leader>',
    })
  end,
  config = function()
    require('iron.core').setup {
      config = {
        scratch_repl = true,
        repl_open_cmd = require('iron.view').bottom '40%',
        repl_definition = {
          node = {
            command = { 'node' },
          },
        },
        highlight = { italic = true },
        ignore_blank_lins = true,
        keymaps = {
          send_motion = '<c-c>',
          visual_send = '<c-cr>',
          send_file = '<leader>rsf',
          send_line = '<c-cr>',
          send_mark = '<leader>rsm',
          mark_motion = '<leader>rmc',
          mark_visual = '<leader>rmc',
          remove_mark = '<leader>rmd',
          cr = '<leader>r<cr>',
          interrupt = '<leader>ri<leader>',
          exit = '<leader>rq',
          clear = '<leader>rc',
        },
      },
    }
  end,
}
