return {
  {

    'nvim-neotest/neotest',
    optional = true,
    dependencies = { 'nvim-neotest/neotest-python' },
    opts = {
      adapters = {
        ['neotest-python'] = {},
      },
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    opts = {
      name = {
        'venv',
        '.venv',
        'env',
        '.env',
      },
    },
    keys = {
      {
        '<leader>cv',
        '<cmd>VenvSelect<cr>',
        desc = 'select virtualenv',
      },
    },
  },
}
