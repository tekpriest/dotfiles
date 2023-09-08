return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    icons = false,
    action_keys = {
      open_split = 'S',
      open_vsplit = 's',
      switch_severity = { '<c-s>' },
    },
    fold_open = 'v',
    fold_closed = '>',
    indent_lines = false,
    signs = {
      error = 'E',
      warning = 'W',
      hint = 'H',
      information = 'I',
    },
    use_diagnostic_signs = false,
    auto_close = true,
  },
  keys = {
    {
      '<leader>xd',
      function()
        require('trouble').open 'document_diagnostics'
      end,
      desc = 'document diagnostics',
    },
    {
      '<leader>xw',
      function()
        require('trouble').open 'workspace_diagnostics'
      end,
      desc = 'workspace diagnostics',
    },
    {
      'gr',
      function()
        require('trouble').open 'lsp_references'
      end,
      desc = 'lsp references',
    },
  },
}
