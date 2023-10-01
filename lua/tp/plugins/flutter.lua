return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  ft = { 'dart' },
  config = function()
    local Utils = require 'tp.lsp.setup'
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
