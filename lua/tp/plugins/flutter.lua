local Utils = require 'tp.lsp.setup'
return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    require('flutter-tools').setup {
      widget_guides = {
        enabled = true,
      },
      lsp = {
        color = {
          enabled = true,
        },
        on_attach = Utils.on_attach,
        capabilities = Utils.capabilities,
      },
    }
  end,
}
