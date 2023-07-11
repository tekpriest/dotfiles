return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  opts = {
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
  },
  config = function(_, opts)
    require('refactoring').setup(opts)

    local wk = require 'which-key'
    wk.register({
      r = {
        a = {
          "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
          'refactor code',
        },
        c = {
          "<cmd>lua require('refactoring').debug.cleanup({})<cr>",
          'cleanup',
        },
      },
    }, {
      prefix = '<leader>',
    })
  end,
}
