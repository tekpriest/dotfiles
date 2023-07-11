return {
  'folke/persistence.nvim',
  -- event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {},
  config = function(_, opts)
    require('persistence').setup(opts)
    local wk = require 'which-key'

    wk.register({
      -- session management
      q = {
        s = {
          function()
            require('persistence').load()
          end,
          'load directory session',
        },
      },
    }, {
      prefix = '<leader>',
    })
  end,
}
