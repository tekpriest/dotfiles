return {
  'L3MON4D3/LuaSnip',
  config = function()
    local snip = require 'luasnip'
    local types = require 'luasnip.util.types'

    require('luasnip/loaders/from_vscode').lazy_load()

    snip.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      anable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticHint' } },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { '●', 'DiagnosticInfo' } },
          },
        },
      },
    }
  end,
}
