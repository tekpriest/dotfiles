return {
  'cshuaimin/ssr.nvim',
  name = 'ssr',
  config = function()
    require('ssr').setup()

    local wk = require 'which-key'
    wk.register({
      s = {
        name = 'search',
        s = { '<cmd>lua require("ssr").open()<cr>', 'run ssr' },
      },
    }, {
      prefix = '<leader>',
    })
  end,
}
