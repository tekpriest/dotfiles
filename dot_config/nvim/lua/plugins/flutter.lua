return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = true,
  keys = {
    { '<localleader>fr', ':FlutterRun<cr>', desc = 'Run application' },
    { '<localleader>fq', ':FlutterQuit<cr>', desc = 'Quit' },
  },
}
