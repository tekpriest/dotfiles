return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {
    snippet_engine = 'luasnip',
  },
  cmd = 'Neogen',
  config = function(_, opts)
    require('neogen').setup(opts)

    local wk = require 'which-key'

    wk.register {
      n = {
        name = 'neogen',
        n = { '<cmd>lua require("neogen").generate()<cr>', 'generate' },
      },
    }
  end,
}
